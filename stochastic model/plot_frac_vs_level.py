from CellStoch import *
from scipy.io import savemat
from utils import get_value
thres = 25
time=[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
def f(save_name):
    print(save_name)
    m=sinIR_full()
    tap=[0 for i in time]
    tap_pure=[0 for i in time]
    frac=[0 for i in time]
    i=0
    while(get_value("sinIR_full",save_name,i,"TapA",1)!=-1):
        print(i)
        for ii,tt in enumerate(time):
            val = get_value("sinIR_full", save_name, i, "TapA", tt)
            tap[ii]+=val
            if val > thres:
                tap_pure[ii]+=val
                frac[ii]+=1
        i+=1
    tap_pure=[x/frac[i] for i,x in enumerate(tap_pure)]
    tap=[x/(i-1) for x in tap]
    frac = [t/(i-1) for t in frac]

    savemat(os.path.join(m.analyze_dir,save_name+'.frac_vs_mean.mat'),{'time':time,'frac':frac,'mean':tap,'mean_active':tap_pure})

for sa in ['full_ds', 'full_dc', 'full_da', 'gr_change_n100']:
        f(save_name=sa)
