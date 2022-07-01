import numpy as np
import scipy.signal,os
modeldir=os.path.dirname(os.path.abspath(__file__))
from scipy.interpolate import interp1d
import pickle

def get_full_dynamics(model,sampleunit=0.05,start_time=0):
    '''
    return a dictionary {species:[...(dynamics)],...'time':[...]}
    '''
    data=model.data_stochsim
    out_dict={}
    for i in data.species_labels:
        time=data.time
        species_traj=get_species(data,i)
        out_dict[i]=species_traj
    out_dict['time']=time+start_time
    return out_dict

def get_end_value(model):
    out_dict={}
    if isinstance(model,dict):# if the model is sampled data
        for i in model:
            if i!='time':
                out_dict[i]=model[i][-1]
    else:
        data=model.data_stochsim
        for i in data.species_labels:
            out_dict[i]=list(get_species(data,i))[-1]
    return out_dict

def get_species(data,species):
    return data.species[:,data.species_labels.index(species)]

def sample(time,dynamics,timeunit=0.01):
    #y:data in shape(data,species)
    x=time
    y=dynamics
    j=1
    out=np.array(y[0])
    out_t=[x[0]]
    i=1
    while i<len(x):
        if x[i]>=out_t[0]+j*timeunit:
            new=y[i-1]
            j=j+1
            out=np.hstack((out,new))
            out_t.append(out_t[0]+j*timeunit)
        else:
            i=i+1
    return np.array(out_t),out
def get_value(model,set,no,species,time):
    m_dir=os.path.join(modeldir,'model',model)
    pkls_dir=os.path.join(m_dir,'cell_lines')
    fname=set+'_'+str(no)+'.pkl'
    if fname not in os.listdir(pkls_dir):
        return -1
    f=open(os.path.join(pkls_dir,fname),'rb')
    full_dynamics=pickle.load(f)
    f.close()
    if time>full_dynamics['time'][-1]:
        return -1
    f=interp1d(full_dynamics['time'],full_dynamics[species])
    return f(time)
