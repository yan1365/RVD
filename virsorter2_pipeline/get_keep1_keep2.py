#!/usr/bin/env python
import os
import pandas as pd 
import numpy as np 
import sys
import glob
from Bio import SeqIO
import re

def vs2(dataset, sample_id):
    os.chdir(f'/fs/ess/PAS0439/MING/virome/virus_contigs/vs2_pipeline/vs2_pass1/{dataset}')
    sample=''.join(glob.glob(f'{sample_id}*')).split('_vs2')[0]
    
    vs2 = pd.read_csv(f'{sample}_vs2_pass1/final-viral-score.tsv', sep='\t')
    checkv = pd.read_csv(f'/fs/ess/PAS0439/MING/virome/checkv_res/{dataset}/{dataset}_{sample}/contamination.tsv', sep = '\t') 

    mydf = checkv.merge(vs2, right_on='seqname', left_on='contig_id')
    mydf.drop("seqname",axis=1, inplace=True)


    keep1_provirus = list(mydf.query('provirus == "Yes"').query('viral_genes > 0').query('proviral_length > 5000')['contig_id'])
    keep1_fullvirus = list(mydf.query('provirus == "No"').query('viral_genes > 0').query('contig_length > 5000')['contig_id'])
    keep2_provirus = list(mydf.query('viral_genes == 0').query('provirus == "Yes"').query('host_genes == 0|max_score >= 0.95|hallmark > 2').query('proviral_length > 5000')['contig_id'])
    keep2_fullvirus = list(mydf.query('viral_genes == 0').query('provirus == "No"').query('provirus == "Yes"').query('host_genes == 0|max_score >= 0.95|hallmark > 2').query('contig_length > 5000')['contig_id'])
    keep = keep1_provirus + keep1_fullvirus + keep2_provirus + keep2_fullvirus

    
    records =  SeqIO.parse(f'/fs/ess/PAS0439/MING/virome/checkv_res/{dataset}/{dataset}_{sample}/final-viral-combined.fa', 'fasta') 
        
    file = open(f'/fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/keep1_keep2/{dataset}/{sample}_keep1_2.fa','w+')
    for record in records:
        name = record.name
        ## checkv add trailing _1 when contigs were trimed, so the record.name inconsistent with the contig name in contamination.tsv and vs reults
        renamed = re.sub('_[0-9]$', '', name)
        if renamed in keep:
            SeqIO.write(record, file, 'fasta')
            
            
    file.close()
    

if __name__ == "__main__":
    dataset = str(sys.argv[1])    
    sample_id = str(sys.argv[2])
    vs2(dataset, sample_id)

    
    
    
    


                

            
    





