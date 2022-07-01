from multiprocessing import Pool
from CellStoch import *
class sinIR_direct(CellModel):
    def __init__(self,*args,**kwargs):
        genes=['gsini0','gsini1','gsini2','gslrr0','gslrr1','gsinr','gtap0','gtap1']
        super().__init__('sinIR_direct',genes=genes,*args,**kwargs)


def f(mode):
    if mode=="ds_1":
        m=sinIR_full()
        resume=False
        m.sim_cell_lines(setting="ds",mode="feedback",max_time=16,num_of_lines=1000,resume=resume,save_name='ds_feedback_bgdeg')
        m.generate_avg_figures(['TapA'],save_name='ds_feedback_bgdeg',xlim=(2,20),ylim=(0,100),plot_traj=False)
    elif mode=="ds_2":
        m=sinIR_direct()
        resume=True
        m.sim_cell_lines(setting="ds",mode="n100",max_time=16,num_of_lines=100,resume=resume,save_name='ds_direct')
        m.generate_avg_figures(['TapA'],save_name='ds_direct',xlim=(2,20),ylim=(0,100),plot_traj=False)
    elif mode in ["n100","n10","n1"]:
        m=sinIR_full()
        resume=False
        m.sim_cell_lines(setting="wt",mode="mode",max_time=16,num_of_lines=100,resume=resume,save_name='gr_change_bgdeg_'+mode)
        m.generate_avg_figures(['TapA'],save_name='gr_change_bgdeg_'+mode,xlim=(2,20),ylim=(0,100),plot_traj=False)
    elif mode in ["da","dc","ds"]:
        m=sinIR_full()
        resume=False
        m.sim_cell_lines(setting=mode,mode="n100",max_time=16,num_of_lines=100,resume=resume,save_name='full_bgdeg_'+mode)
        m.generate_avg_figures(['TapA'],save_name='full_bgdeg_'+mode,xlim=(2,20),ylim=(0,100),plot_traj=False)
if __name__ == '__main__':
    with Pool(8) as p:
        print(p.map(f, ['ds_1']))



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
