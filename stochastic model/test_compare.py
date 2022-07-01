from multiprocessing import Pool
from CellStoch import *
class sinIR_compare(CellModel):
    def __init__(self,*args,**kwargs):
        genes=['gsini0','gsini1','gsini2','gslrr0','gslrr1','gsinr','gtap0','gtap1']
        super().__init__('sinIR_direct',genes=genes,*args,**kwargs)
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
                gr=self.get_growth_rate(self.current_time,mode=gr_mode)
            else:
                gr=self.get_growth_rate(self.current_time)
        self.vol=self.vol_0/2**(0.95*(1.1-gr))
        t1=(0.78+0.15/gr)*0.8/(0.69/gr)
        t2=(0.78+0.15/gr)*0.8/(0.69/gr)
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
                self.model.DoCellDivisionStochSim(end=1,mode="generations", trajectories=1,minimal_time_interval=self.minimal_time_interval,quiet=True)
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

def f(mode):
    if mode=="compare1":
        m=sinIR_compare(minimal_time_interval=0.1,parameter_change={})
        resume=False
        m.sim_cell_lines(setting="wt",mode="feedback",minimal_time_interval=0.1,max_time=16,num_of_lines=500,resume=resume,save_name='compare_pos')
        m.generate_avg_figures(['TapA'],save_name='compare_pos',xlim=(2,20),ylim=(0,100),plot_traj=False)
    elif mode=="compare2":
        m=sinIR_compare(minimal_time_interval=0.1,parameter_change={"kdeg_slr":0.2})
        resume=True
        m.sim_cell_lines(setting="wt",mode="n100",minimal_time_interval=0.1,max_time=16,num_of_lines=500,resume=resume,save_name='compare_pos_deg')
        m.generate_avg_figures(['TapA'],save_name='compare_pos_deg',xlim=(2,20),ylim=(0,100),plot_traj=False)



if __name__ == '__main__':
    with Pool(8) as p:
        print(p.map(f, ['compare2','compare1']))



'''
def sample_lines(save_name,numbers,species):
    plt.clf()
    m=sinIR_full(minimal_time_interval=0.1)
    for i in numbers:
        full_dynamics=m.__get_pkl_data__(save_name,i)
        time=[t-3 for t in full_dynamics['time']]
        c=full_dynamics[species]
        plt.plot(time,c)
    plt.xlabel('time')
    plt.xlim([2,16])
    plt.ylabel('number')
    imgname=save_name+"_sample.png"
    plt.savefig(os.path.join(m.analyze_dir,imgname))

sample_lines("test_clines_wt",[68,69,85,86,67,68,105],'SlrR_d')
sample_lines("test_clines_da",[68,69,85,86,67,68,105],'SlrR_d')
sample_lines("test_clines_ds",[1,2,3,4,5,82,116],'SlrR_d')
sample_lines("test_clines_dc",[1,2,3,4,5,82,116],'SlrR_d')
'''
