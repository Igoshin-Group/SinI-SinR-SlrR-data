'''
test the cases under constant 0A~P
'''
from multiprocessing import Pool
from CellStoch import *

class sinIR_test(CellModel):
    def __init__(self,*args,**kwargs):
        genes=['gsini0','gsini1','gslrr0','gslrr1','gsinr']
        super().__init__('sinIR_test',genes=genes,*args,**kwargs)

def f():
    m=sinIR_full(minimal_time_interval=0.1)
    m.static_cycles(0.1,0.5,max_time=200,num_of_lines=5,resume=False,save_name='test_mono')

f()
