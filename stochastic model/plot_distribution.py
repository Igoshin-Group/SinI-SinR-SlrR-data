
from multiprocessing import Pool
from CellStoch import *
from scipy.io import savemat

def get_dist_plot(bins=np.linspace(0,800,40),sample_time=7,save_name='test',threshold=0,species=['TapA'],ax=None):
    plt.clf()
    m=sinIR_full()
    wt=m.generate_distribution_figures(species,save_name=save_name,sample_time=sample_time,bins=50,threshold=threshold,plot=False)
    if ax==None:
        ax=plt.axes()
    tap,edges,_=ax.hist(wt,bins=bins,weights=np.ones_like(wt) / len(wt), edgecolor='black')
    plt.savefig(os.path.join(m.analyze_dir,save_name+'_time_{}.png'.format(sample_time)),format = 'png')
    savemat(os.path.join(m.analyze_dir,save_name+'_time_{}.mat'.format(sample_time)),{'TapA':tap,'edges':edges})
    return ax


for sa in ['full_ds', 'full_dc', 'full_da', 'gr_change_n100', 'no_gr_noise_da', 'no_gr_noise_ds', 'no_gr_noise_dc', 'no_gr_noise_wt']:
    for time in [1,2,3,4,5,6,7,8,10,12]:
        print(sa,time)
        get_dist_plot(save_name=sa,sample_time=time)
