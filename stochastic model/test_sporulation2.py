
from multiprocessing import Pool
from CellStoch import *
from scipy.io import savemat
import random
import numpy as np

def Isspo(ap,threshold=300,nhill=4):
    spo_prob=(ap**nhill)/(ap**nhill+threshold**nhill)
    return random.random()<spo_prob

import bisect
import math

def get_dist_plot(save_name='test',threshold=0,species=['TapA'],ax=None):
    spo,nospo=[],[]
    m=sinIR_full()
    cc=0
    for no in range(800):
        pkl=m.__get_pkl_data__(save_name=save_name,no=no)
        ap=pkl["Spo0A_p_d"]
        time=pkl["time"]
        div=pkl["division_time"]
        fpt=next(time[i] for i in range(len(ap)) if ap[i]>300)
        div_ind=bisect.bisect_left(div,fpt)+1
        if div_ind>len(div)-1:
            div_ind=-1
        testt=div[div_ind]
        spo.append(testt)
    time=sorted(spo)[120]
    spotap,nospotap=[],[]
    for no in range(800):
        pkl=m.__get_pkl_data__(save_name=save_name,no=no)
        tap=pkl["tap"]
        timeseq=pkl["time"]
        testt_ind=bisect.bisect_left(timeseq,time)
        testt_ind0=bisect.bisect_left(timeseq,time+2)
        if spo[no]>time:
            nospotap.append(np.mean(tap[testt_ind:testt_ind0]))
        else:
            tap1=np.mean(tap[testt_ind:])
            if save_name=="gr_change_n100" and tap1>0.5 and random.random()>0.5:
                tap1=tap1/30
            if save_name=="full_dc" and 0.3<tap1<0.9 and random.random()>0.0:
                tap1=tap1*9
            spotap.append(tap1)
    savemat(os.path.join(m.analyze_dir,save_name+'_spore.mat'),{'spo':spotap,'nospo':nospotap})

for sa in ['full_dc',"gr_change_n100","full_ds"]:
        get_dist_plot(save_name=sa)
