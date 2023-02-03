#!/usr/bin/env python
import os
import pandas as pd 
import numpy as np 
import sys
import glob
import math
import get_keep1_keep2 as vs2 

os.chdir('/fs/ess/PAS0439/MING/virome/checkv_res/')

dataset={'ASS':[],'sheep':[],'mix':[], 'cattle':[], 'CBR':[]}

for key in dataset:
    mylist=[]
    for i in glob.glob(f'{key}/{key}*'):
        mylist.append(i.split('_')[1])
        dataset[key]= mylist    

for data in dataset:
    for sample_id in dataset[data]:
        vs2.vs2(data, sample_id)



    
    
    
    


                

            
    





