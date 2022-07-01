from multiprocessing import Pool
from CellStoch import *


def f(mode):
        m=sinIR_full()
        resume=True
        m.gr_cv=0
        m.sim_cell_lines(setting=mode,mode="wt",max_time=16,num_of_lines=1000,resume=resume,save_name='no_gr_noise_'+mode)
        #m.generate_avg_figures(['TapA'],save_name='full_bgdeg_'+mode,xlim=(2,20),ylim=(0,100),plot_traj=False)
if __name__ == '__main__':
    for x in ['da', 'dc', 'ds', 'wt']:
        f(x)



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
