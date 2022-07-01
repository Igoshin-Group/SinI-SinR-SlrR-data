from multiprocessing import Pool
from CellStoch import *
from scipy.io import savemat
import matplotlib.pyplot as plt
def f(save_name):
    m=sinIR_full()
    #m.generate_avg_figures(['SlrR_d','SinR_SlrR_t'],do_sum=True,save_name='test_clines_'+setting,xlim=(2,20),ylim=(0,800))
    tt,avg,_=m.generate_avg_figures(['TapA'],do_sum=True,save_name=save_name,xlim=(2,20),ylim=(0,100),plot_traj=False)
    savemat(os.path.join(m.analyze_dir,save_name+'.mat'),{'time':tt,'tapA':avg})


    #m.generate_dynamic_figures(['TapA','SinR_t','SlrR_d'],save_name='test_clines_'+setting)
    #m.generate_avg_figures(['gslrr1','gslrr0'],save_name='test_clines_'+setting,xlim=(2,20),ylim=(0,1))


m=sinIR_full(minimal_time_interval=0.1)

tc,ac,sc=m.generate_avg_figures(['TapA'],"full_dc",do_sum=True,sample_time_unit=0.1,xlim=(2,15),ylim=(0,200),plot_avg=True,plot_traj=True,filter=[])
ta,aa,sa=m.generate_avg_figures(['TapA'],"full_da",do_sum=True,sample_time_unit=0.1,xlim=(2,15),ylim=(0,200),plot_avg=True,plot_traj=True,filter=[])
ts,As,ss=m.generate_avg_figures(['TapA'],"full_ds",do_sum=True,sample_time_unit=0.1,xlim=(2,15),ylim=(0,200),plot_avg=True,plot_traj=True,filter=[])
tw,aw,sw=m.generate_avg_figures(['TapA'],"gr_change_n100",do_sum=True,sample_time_unit=0.1,xlim=(2,15),ylim=(0,200),plot_avg=True,plot_traj=True,filter=[])

plt.xlim((2,30))
plt.ylim((0,200))
plt.plot(ts,As["sum"])
plt.plot(tc,ac["sum"])
plt.plot(ta,aa["sum"])
plt.plot(tw,aw["sum"])

plt.show()
input()
