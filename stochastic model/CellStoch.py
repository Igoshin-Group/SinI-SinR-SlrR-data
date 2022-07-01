import utils,os,pickle,gc,math,sys
stochpydir=os.path.join(os.path.dirname(os.path.abspath(__file__)),'stochpy')
sys.path.append(stochpydir)
modeldir=os.path.dirname(os.path.abspath(__file__))
import stochpy
import matplotlib.pyplot as plt
import numpy as np
from scipy.interpolate import interp1d
import scipy
import bisect
import traceback
import random
from pathlib import Path

class CellModel:
    def __init__(self,modelname,genes=[],vol=1,parameter_change={}):
        self.genes=genes
        self.vol_0=2
        self.vol=2
        self.gr_cv=0.25
        self.fix_time=0
        self.min_gr=0.06
        self.min_time_int=0.1
        self.is_spore=False
        self.parameter_change=parameter_change
        self.modeldir=os.path.join(modeldir,'model',modelname)
        self.model=stochpy.CellDivision(IsQuiet=True)
        self.current=None # current species dict {species:amount, ...}
        self.history=None # current cell line history. {time:[...], species1:[...], species2:[...]...,division_time:[...]}
        self.current_cell_line=0 # the trajectories of the batch work. is a list of history
        self.current_time=0 # current time
        self.spo_threshold=None
        self.pkls_dir=os.path.join(self.modeldir,"cell_lines")
        self.analyze_dir=os.path.join(self.modeldir,'analyze_plots')

    def save_line(self,name='test'):
        f=open(os.path.join(self.pkls_dir,name+'_'+str(self.current_cell_line)+'.pkl'),'wb')
        print(os.path.join(self.pkls_dir,name+'_'+str(self.current_cell_line)+'.pkl'))
        pickle.dump(self.history,f)
        f.close()
    def clean(self,save_name):
        for p in Path(self.pkls_dir).glob(save_name+'*'):
            print(p)
            p.unlink()

    def get_growth_rate(self,time,mode='n100',min_gr=0.06):
        cv=self.gr_cv
        grs=[0.7692,0.7238,0.6512,0.6209,0.5425,0.3573,0.1687,0.0955,0.0370,0.0360,0.0357,0.0355,0.0348,0.0345,0.0344,0.0342,0.03]
        ts=[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,88]
        if mode=="feedback":
            sts=[ts[i]-0.2/(grs[i]) for i in range(len(ts))]
            f=interp1d(sts,grs)
            gr_t=1/f(time)
            gr=max(1/(np.random.normal(gr_t,cv*gr_t)),0.06)
            if gr<0.2 or time>10:
                gr=0.06
            return gr
        if mode=='n100':
            grs=[0.7692,0.7238,0.6512,0.6209,0.5425,0.3573,0.1687,0.0955,0.0370,0.0360,0.0357,0.0355,0.0348,0.0345,0.0344,0.0342,0.03]
        elif mode=='n10':
            grs=[0.76,0.76,0.6,0.4,0.15,0.1,0.1,0.0687,0.0643,0.0630,0.0624,0.0618,0.0613,0.0608,0.0604,0.0604,0.06]
        elif mode=='n1':
            grs=[0.76,0.6,0.15,0.1,0.01,0.01, 0.01,0.01,0.01,0.01,0.01,0.01,0.0327,0.0325,0.0324,0.0321,0.03]
        ts=[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,88]
        sts=[ts[i]-0.2/(grs[i]) for i in range(len(ts))]
        f=interp1d(sts,grs)
        if self.fix_time and time>self.fix_time:
            time=self.fix_time
        gr_t=1/f(time)

        gr=max(1/(np.random.normal(gr_t,cv*gr_t)),min_gr)
        return gr
    def __get_pkl_data__(self,save_name,no):
        '''
        return unpickled data
        if not exist, return None
        '''
        fname=save_name+'_'+str(no)+'.pkl'
        pkls_dir=self.pkls_dir
        if fname not in os.listdir(pkls_dir):
            return None
        f=open(os.path.join(self.pkls_dir,fname),'rb')
        full_dynamics=pickle.load(f)
        f.close()
        return full_dynamics
    def display_cell_line(self,species,save_name,cell_line_no=0):
        '''
        species: list of str
        '''
        full_dynamics=self.__get_pkl_data__(save_name,cell_line_no)
        time=full_dynamics['time']
        for i in species:
            dynamics=full_dynamics[i]
            plt.plot(time,dynamics)
        plt.legend(species)
        plt.xlabel('time')
        plt.ylabel('number')
        plt.show()
        input()
    def generate_dynamic_figures(self,species,save_name,**kwargs):
        fig_dir=os.path.join(self.modeldir,'dynamics_plots')
        imgno=0
        if 'imgno' in kwargs:
            imgno=kwargs['imgno']
        full_dynamics=self.__get_pkl_data__(save_name,imgno)
        while full_dynamics:
            plt.clf()
            time=full_dynamics['time']
            for i in species:
                dynamics=full_dynamics[i]
                plt.plot(time,dynamics)
            plt.legend(species)
            plt.xlabel('time')
            plt.ylabel('number')
            if 'ylim' in kwargs:
                plt.ylim(kwargs['ylim'])
            if 'xlim' in kwargs:
                plt.xlim(kwargs['xlim'])
            maxy=plt.gca().get_ylim()[1]
            #for dt in full_dynamics['division_time']:
                #plt.plot([(dt),(dt)],[0,maxy],'r--',linewidth=0.5)
            imgname=save_name+'_'+str(imgno)+'.png'
            imgno+=1
            full_dynamics=self.__get_pkl_data__(save_name,imgno)
            plt.savefig(os.path.join(fig_dir,imgname))
            plt.clf()
            if 'imgno' in kwargs:
                break
    def generate_avg_figures(self,species,save_name,do_sum=False,sample_time_unit=0.01,xlim=(3,8),ylim=(0,150),plot_avg=True,plot_traj=True,filter=[]):
        '''
        species: list of species names
        if sum=true: plot the sums

        return :
        time: [times]
        avg:{species:[avg]} or ['sum':avg]
        std:{species:[avg]} or ['sum':avg]
        '''
        fig_dir=self.analyze_dir
        imgno=0
        full_dynamics=self.__get_pkl_data__(save_name,imgno)
        vals={i:{} for i in species} if not do_sum else {'sum':{}}
        imgname=save_name+'_'+'_avg.svg'
        long_time=[]
        while full_dynamics:
            if imgno not in  filter:
                time=full_dynamics['time']
                if not do_sum:
                    for i in species:
                        if plot_traj:
                            plt.plot(time,full_dynamics[i],alpha=0.2,color='black')
                        sample_time,sample_dynamics=utils.sample(time,full_dynamics[i],timeunit=sample_time_unit)
                        for j in range(len(sample_dynamics)):
                            if j in vals[i]:
                                vals[i][j].append(sample_dynamics[j])
                            else:
                                vals[i][j]=[sample_dynamics[j]]
                else:
                    temp=[]
                    for i in species:
                        sample_time,temp_dynamics=utils.sample(time,full_dynamics[i],timeunit=sample_time_unit)
                        temp.append(list(temp_dynamics))
                    sample_dynamics=[sum(x) for x in zip(*temp)]
                    for j in range(len(sample_dynamics)):
                        if j in vals['sum']:
                            vals['sum'][j].append(sample_dynamics[j])
                        else:
                            vals['sum'][j]=[sample_dynamics[j]]
                    if plot_traj:
                        plt.plot(sample_time,sample_dynamics,alpha=0.2,color='black')
                long_time=sample_time if len(sample_time)>len(long_time) else long_time
            imgno+=1
            full_dynamics=self.__get_pkl_data__(save_name,imgno)
        lines=[]
        avg={i:[] for i in vals.keys()}
        std={i:[] for i in vals.keys()}
        for i in vals.keys():
            for j in range(1+max(vals[i].keys())):
                std[i].append(np.std(vals[i][j]))
                avg[i].append(np.mean(vals[i][j]))
        if plot_avg:
            for i in vals.keys():
                lines.append(plt.plot(long_time,avg[i],linewidth=2)[0])
            plt.legend(lines,species)
        plt.xlabel('time')
        plt.ylabel('number')
        plt.xlim(xlim)
        plt.ylim(ylim)
        plt.savefig(os.path.join(fig_dir,imgname))
        plt.clf()
        return long_time,avg,std
    def get_sample(self,species,save_name,sample_time,dynamic_id):
        full_dynamics=self.__get_pkl_data__(save_name,dynamic_id)
        if not full_dynamics:
            return None # file not found
        time=full_dynamics['time']
        if sample_time>time[-1]:
            return -1  # beyond time range
        p=0
        for i in species:
            dynamics=full_dynamics[i]
            time_index=bisect.bisect_left(time,sample_time)
            p+=dynamics[time_index]
        return p
    def generate_distribution_figures(self,species,save_name,sample_time,threshold=0,filter=[],plot=True,imgno_range=None,**kwargs):
        '''
        sample_time:float
        species: [] (the sum of all the species)
        '''
        imgno=0
        imgmax=float('inf')
        if imgno_range:
            imgno=imgno_range[0]
            imgmax=imgno_range[1]
        fig_dir=self.analyze_dir
        imgname=save_name+'_T'+str(sample_time)+'_distribution.png'
        full_dynamics=self.__get_pkl_data__(save_name,imgno)
        values=[]
        while full_dynamics and imgno<=imgmax:
            if imgno not in filter:
                time=full_dynamics['time']
                if sample_time>time[-1]:
                    imgno+=1
                    full_dynamics=self.__get_pkl_data__(save_name,imgno)
                    continue
                p=0
                for i in species:
                    dynamics=full_dynamics[i]
                    time_index=bisect.bisect_left(time,sample_time)
                    p+=dynamics[time_index]
                if p>=threshold:
                    values.append(p)
            imgno+=1
            full_dynamics=self.__get_pkl_data__(save_name,imgno)
        if plot:
            plt.clf()
            plt.hist(values,**kwargs)
            plt.xlabel('[{species}]'.format(species='_'.join(species)))
            plt.ylabel('frequency')
            plt.savefig(os.path.join(fig_dir,imgname))
            plt.clf()
        return values
    def get_0Ap(self,growth_rate,setting):
        grs=[10,1,0.9,0.8,0.7,0.6,0.5,0.4,0.3,0.2,0.1,0]
        wt_aps=[0.16,0.16,0.16,0.2,0.3,0.4,0.7,1,1.3,1.5,1.8,1.8]
        da_aps=[0.15,0.15,0.15,0.15,0.23,0.24,0.25,0.27,0.32,0.35,0.4,0.4]
        ds_aps=[0.7,0.7,0.7,0.7,0.9,1.2,1.5,1.8,2.3,2.8,3.3,3.3]
        dc_aps=[0.01,0.01,0.01,0.01,0.03,0.08,0.27,1.8,2.7,3,3.5,3.5]

        if setting=='wt':
            f=interp1d(grs,wt_aps)
        elif setting=='ds':
            f=interp1d(grs,ds_aps)
        elif setting=='da':
            f=interp1d(grs,da_aps)
        elif setting=='dc':
            f=interp1d(grs,dc_aps)
        else:
            return setting
        return f(growth_rate)
    def sim_cell_lines(self,max_time=8,num_of_lines=1,save_name='test',setting='wt',resume=True,mode=None):
        '''
        resume: resume previous data
        '''
        start_no=0
        if resume:
            while self.__get_pkl_data__(save_name,start_no):
                start_no+=1
        self.current_cell_line=start_no
        while  self.current_cell_line < num_of_lines:
            print(self.current_cell_line)
            self.restart(setting)
            try:
                while self.current_time<max_time:
                    self.next_cycle(setting=setting,gr_mode=mode)
            except Exception as e:
                continue
            self.save_line(name=save_name)
            self.current_cell_line+=1
    def restart(self,setting,gr=None,pre_sim=True):
            self.history=None
            self.is_spore=False
            self.current_time=0
            self.model.Model(os.path.join(self.modeldir,"model.psc"))
            for p in self.parameter_change:
                self.model.ChangeParameter(p,self.parameter_change[p])
            self.model.Method('NRM')
            self.model.SetExactDividingSpecies(self.genes)
            if gr==None:
                gr=self.get_growth_rate(self.current_time)
            self.model.SetGrowthFunction(gr)
            ap=self.get_0Ap(gr,setting)
            self.model.ChangeInitialSpeciesCopyNumber('Spo0A_p_d',float(ap))
            self.model.SetVolumeDistributions(('fixed',self.vol*2),('fixed',0.5))
            self.model.SetInitialVolume(self.vol)
            gc.collect()
            if pre_sim:
                for c in range(4):
                    while (1):
                        try:
                            self.model.DoCellDivisionStochSim(end=1,mode="generations",minimal_time_interval=self.min_time_int, trajectories=1,quiet=True,)
                            break
                        except:
                            continue
                    self.current=utils.get_end_value(self.model)
                    for i in self.current:
                        if i not in self.genes:
                            count=0
                            while (count<8):
                                try:
                                    self.model.ChangeInitialSpeciesCopyNumber(i,(round(np.random.binomial(self.current[i],0.5))))
                                    break
                                except:
                                    count+=1
                                    continue
    def next_cycle(self,setting,gr=None,gr_mode=None):
        # setting:ap
        # gr: gr
        gc.collect()
        if self.current:
            for i in self.current:
                if i not in self.genes:
                    try:
                        self.model.ChangeInitialSpeciesCopyNumber(i,round(np.random.binomial(self.current[i],0.5)))
                    except:
                        print(i,self.current[i])
                        raise
        if not gr:
            if gr_mode!=None:
                gr=self.get_growth_rate(self.current_time,mode=gr_mode,min_gr=self.min_gr)
            else:
                gr=self.get_growth_rate(self.current_time,min_gr=self.min_gr)
        self.vol=self.vol_0/2**(0.95*(1.1-gr))
        t1=(0.78+0.15/gr)*0.8/(0.69/gr)
        t2=(0.78+0.15/gr)*0.3/(0.69/gr)
        t3=(0.78+0.15/gr)*0.43/(0.69/gr)

        ap=self.get_0Ap(gr,setting)
        if self.spo_threshold!=None:
                nhill=12
                spo_prob=(ap**nhill)/(ap**nhill+self.spo_threshold**nhill)
                print('ap({0}):'.format(setting)+str(ap)+", prob:"+str(spo_prob))
                if self.is_spore or random.random()<spo_prob:
                    print("##   spore. tap:"+str(self.current["TapA"]))
                    self.model.ChangeInitialSpeciesCopyNumber("gtap0",0)
                    self.model.ChangeInitialSpeciesCopyNumber("gtap1",0)
                    self.model.ChangeInitialSpeciesCopyNumber("tap",0)
                    self.is_spore=True
        self.model.SetGeneDuplications(['gsini0','gsini1','gsinr','gslrr0','gslrr1','gtap0','gtap1'],[t1,t1,t1,t2,t2,t3,t3])
        ap=1/8*(13+4*ap-13**0.5*(13+8*ap)**0.5)*self.vol*2000
        self.model.SetGrowthFunction(gr)
        self.model.ChangeInitialSpeciesCopyNumber('Spo0A_p_d',float(ap))
        self.model.SetInitialVolume(self.vol)
        self.model.SetVolumeDistributions(('fixed',self.vol*2),('fixed',0.5))
        fail=True
        while fail:
            try:
                self.model.DoCellDivisionStochSim(end=1,mode="generations", minimal_time_interval=self.min_time_int,trajectories=1,quiet=True)
                fail=False
            except KeyboardInterrupt:
                raise
            except AssertionError:
                _, _, tb = sys.exc_info()
                traceback.print_tb(tb) # Fixed format
                tb_info = traceback.extract_tb(tb)
                filename, line, func, text = tb_info[-1]
                print('An error occurred on line {} in statement {}'.format(line, text))
                gc.collect()
                continue
        out_dict=utils.get_full_dynamics(self.model,start_time=self.current_time)
        if self.history==None:
            self.history={}
            for i in out_dict:
                    self.history[i]=out_dict[i]
            self.history['division_time']=[self.current_time]

        else:
            for i in self.history:
                if i=='division_time':
                    self.history['division_time'].append(self.current_time)
                else:
                    self.history[i]=np.hstack((self.history[i],out_dict[i][1:]))
        self.current_time=out_dict['time'][-1]
        self.current=utils.get_end_value(out_dict)
        print('time:'+str(self.current_time))

    def static_cycles(self,ap,gr,max_time=80,num_of_lines=1,save_name='test',resume=True):
        start_no=0
        if resume:
            while self.__get_pkl_data__(save_name,start_no):
                start_no+=1
        self.current_cell_line=start_no
        while  self.current_cell_line < num_of_lines:
            print(self.current_cell_line)
            self.restart(ap,gr=gr,pre_sim=False)
            while self.current_time<max_time:
                self.next_cycle(setting=ap,gr=gr)
            self.save_line(name=save_name)
            self.current_cell_line+=1


class sinIR_full(CellModel):
    def __init__(self,*args,**kwargs):
        genes=['gsini0','gsini1','gslrr0','gslrr1','gsinr','gtap0','gtap1']
        super().__init__('sinIR_full',genes=genes,*args,**kwargs)
