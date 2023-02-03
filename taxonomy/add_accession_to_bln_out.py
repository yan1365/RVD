#!/usr/bin/env python
import re
import os
import pandas as pd
import numpy as np
import glob

def add_accession():
    os.chdir('/fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/taxonomy/output')
    print('test')
    bln = glob.glob('refseq_virus_*.bln')
    bln_list = []
    for f in bln:
        df = pd.read_csv(f, sep= '\t', header = None, names='qseqid sseqid pident length qlen slen mismatch gapopen qstart qend sstart send evalue bitscore'.split(' '))[['qseqid', 'sseqid', 'evalue', 'bitscore']]
        df_new = df.loc[df.groupby(['qseqid']).evalue.idxmin()].reset_index(drop=True)
        bln_list.append(df_new)
    bln_df = pd.concat(bln_list)
    refseq = pd.read_csv('refseq_viral.tsv' ,sep='\t')

    mydict= {}
    for index, row in refseq.iterrows():
        mydict[row['accession']] =  row['sequence']
    def corresponding_key(val, dictionary):
            for k, v in dictionary.items():
                if val in v:
                    return k

    for index, row in bln_df.iterrows():
        sseqid = row['sseqid']
        bln_df.loc[index, 'accession'] = corresponding_key(sseqid, mydict)

    bln_df.to_csv('refseq_viral_with_accession.tsv', sep='\t', index = None)

if __name__ == "__main__":
    add_accession()