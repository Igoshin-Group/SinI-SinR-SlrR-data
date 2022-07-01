from CellStoch import *
from multiprocessing import Pool
import matplotlib.pyplot as plt
import numpy as np
from  scipy.io import savemat
aps=[0,0.2,2]
grs=[0.1,0.2,0.5]
sets=[(0.2,0.2),(0.2,0.5),(0,0.5),(2,0.1),(2,0.2),(2,0.5),(0.5,0.2),(0.5,0.5),(2,0.3),(0.5,0.8)]

newsets=[(0,0.2),(0.5,0.2),(0,0.1),(0.5,0.1),(2,0.8),(0,0.8)]

m=sinIR_full()
ad=m.analyze_dir
'''
for ap,gr in newsets:
        save_name='test_r_{0}_ap_{1}'.format(gr,ap)
        #m.static_cycles(ap,gr,max_time=20,num_of_lines=100,resume=True,save_name=save_name)
for ap,gr in [(2,0.1)]:
        save_name='test_r_{0}_ap_{1}'.format(gr,ap)
        print(save_name)
        out=[]
        out_sinR=[]
        for time in np.linspace(1,19,50):
            out=out+m.generate_distribution_figures(['SlrR_d'],plot=False,save_name=save_name,sample_time=time,imgno_range=(0,100))
            out_sinR=out_sinR+m.generate_distribution_figures(['SinR_t'],plot=False,save_name=save_name,sample_time=time,imgno_range=(0,100))
        imgname=save_name+'.png'
        savemat(os.path.join(ad,save_name+'.mat'),{'slrR_d':out,'sinR_t':out_sinR})

        xs,bins,_=plt.hist(out,bins=np.linspace(0,1500,30))
        bs=[i+0.5*(bins[1]-bins[0]) for i in bins[:-1]]
        xs=[i/sum(xs) for i in xs]
        plt.clf()
        plt.bar(bs,xs,width=(bins[1]-bins[0]))
        plt.xlabel('tapA')
        plt.ylabel('frequency')
        plt.savefig(os.path.join(ad,imgname))
'''

for ap,gr in [(0,0.5)]:
        save_name='test_r_{0}_ap_{1}'.format(gr,ap)
        save_name2='test_r_{0}_ap_{1}'.format(0,0.2)
        print(save_name)
        out=[]
        out_sinR=[]
        for time in np.linspace(0.25,19.25,50):
            out=out+m.generate_distribution_figures(['SlrR_d'],plot=False,save_name=save_name,sample_time=time,imgno_range=(0,100))
            out_sinR=out_sinR+m.generate_distribution_figures(['SinR_t'],plot=False,save_name=save_name,sample_time=time,imgno_range=(0,100))
        imgname=save_name+'.png'
        savemat(os.path.join(ad,save_name2+'.mat'),{'slrR_d':out,'sinR_t':out_sinR})

        xs,bins,_=plt.hist(out,bins=np.linspace(0,1500,30))
        bs=[i+0.5*(bins[1]-bins[0]) for i in bins[:-1]]
        xs=[i/sum(xs) for i in xs]
        plt.clf()
        plt.bar(bs,xs,width=(bins[1]-bins[0]))
        plt.xlabel('tapA')
        plt.ylabel('frequency')
        plt.savefig(os.path.join(ad,imgname))
