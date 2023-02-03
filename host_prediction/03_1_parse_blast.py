#!/usr/bin/env python
import pandas as pd   
import os
import sys 

#check PNAS gut virome paper 
# "Only hits aligning to the entire length of the spacer and with the following criteria were kept: perfect matches to spacers 16 to 20 nucleotides, matches to
#spacers 20 to 27 nucleotides in which (mismatches + gaps) is 1 or 0, and matches to spacers ≥ 28 nucleotides in which (mismatches + gaps) are 2 or fewer."


def get_spacers(database):
    os.chdir(f'/fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/host_prediction/spacer_out')

    spacers =  pd.read_csv(f'vOTU_vs_{database}_spacers.bln', sep = '\t', header=None)
    spacers.columns = ['qseqid','sseqid','pident','length','mismatch','gapopen','qstart','qend','sstart','send','evalue','bitscore']
    spacers_hit = spacers.query('qend == length & qstart == 1').query('(16 <= length <= 20 & pident == 100) | (20 <= length <= 27 & (mismatch + gapopen) == 1) | (length > 28 & (mismatch + gapopen) <= 2 )')[['qseqid','sseqid']]
    spacers_hit.to_csv(f'../output/{database}_final_spacer.tsv',sep='\t',index=False)
    
if __name__ == "__main__":
    database = sys.argv[1]
    get_spacers(database)