import os 
import pandas as pd 
import numpy as np 
##dataset, mgnify-rumen-v1 or Rgut

def find_prophage_hit(dataset):
    os.chdir(f'/fs/ess/PAS0439/MING/virome/host_prediction/{dataset}-results/Prophage_blast/')
    prophage = pd.read_csv(f'Prophage_blast_{dataset}.tsv',sep='\t')
    out = prophage.query('length > 2500 & pident > 90').query('length > (0.3*slen)').query('((qstart -0) > (0.3*qlen)|(qlen - qend) > (0.3*qlen))').loc[:,['qseqid','sseqid']]
    return out

rumen =  find_prophage_hit('mgnify-rumen-v1')
Rgut = find_prophage_hit('Rgut')

Rgut.to_csv('/fs/ess/PAS0439/MING/virome/host_prediction/Rgut-results/Prophage_blast/Prophage_blast_Rgut_results.tsv',sep = '\t', index=None) 
rumen.to_csv('/fs/ess/PAS0439/MING/virome/host_prediction/mgnify-rumen-v1-results/Prophage_blast/Prophage_blast_mgnify-rumen-v1_results.tsv', sep='\t', index=None)