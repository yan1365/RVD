#!/usr/bin/env python
import os
import pandas as pd 
import numpy as np 
import sys
import glob

def checkv_amg(dataset, sample_id):
    os.chdir(f'/fs/ess/PAS0439/MING/virome/virus_contigs_keep1_2/{dataset}')
    sample=''.join(glob.glob(f'{dataset}_{sample_id}*')).split('.fa')[0]
    
    checkv = pd.read_csv(f'/fs/ess/PAS0439/MING/virome/checkv_res/{dataset}/{sample}/complete_genomes.tsv', sep = '\t') 

    checkv_complete_10kb = list(checkv.query('contig_length >= 10000').query('`confidence_level` == "high"|`confidence_level` == "medium"')['contig_id'])
    checkv_5kb_circular = list(checkv.query(' 10000 >= contig_length >= 5000').query('`confidence_level` == "high"|`confidence_level` == "medium"').query('`prediction_type` == "DTR"')['contig_id'])
    checkv_complete = checkv_complete_10kb + checkv_5kb_circular
    
    
    outfile =  open(f'/fs/ess/PAS0439/MING/virome/checkv_res/{dataset}/{sample}/viruses.fna', 'r') 
    content =  outfile.readlines()

    #outfile_prophage =  open(f'/fs/ess/PAS0439/MING/virome/checkv_res/{dataset}/{sample}/proviruses.fna', 'r') 
    #content_prophage =  outfile_prophage.readlines()
    
    complete_contigs = open(f'/fs/ess/PAS0439/MING/virome/amg_analysis/complete_contigs/{dataset}/{sample}_complete.fa','w')
    for line in range(len(content)):
        if content[line][1:].strip() in checkv_complete:
            complete_contigs.write(content[line])
            complete_contigs.write(content[line+1])
    
    #prophage_contigs = open(f'/fs/ess/PAS0439/MING/virome/amg_analysis/high_confidence_virus_contigs/prophage/{dataset}/{sample}_prophage.fa','w')
    #for line in range(len(content_prophage)):
    #    if "_".join(content_prophage[line][1:].strip().split('_')[0:2]) in checkv_prophage:
    #        prophage_contigs.write(content_prophage[line])
    #        prophage_contigs.write(content_prophage[line+1])
    #    else:
    #        if "_".join(content_prophage[line][1:].strip().split('_')[0:3]) in checkv_prophage:
    #            prophage_contigs.write(content_prophage[line])
    #            prophage_contigs.write(content_prophage[line+1])

    complete_contigs.close()        
    #prophage_contigs.close()
    outfile.close()
    #outfile_prophage.close()

if __name__ == "__main__":
    dataset = str(sys.argv[1])    
    sample_id = str(sys.argv[2])
    checkv_amg(dataset, sample_id)

    
    
    
    


                

            
    





