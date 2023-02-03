import os
import pandas as pd

os.chdir('/fs/ess/PAS0439/MING/virome/amg_analysis/results')

amg_contigs=[]
with open('amg_containing_contigs.txt','r') as infile:
    for f in infile:
        amg_contigs.append(f.strip())

rumen = pd.read_csv('Prophage_blast_mgnify-rumen-v1_results.tsv',sep='\t')
Rgut = pd.read_csv('Prophage_blast_Rgut_results.tsv',sep='\t')       
rumen_phage = pd.read_csv('Prophage_blast_mgnify-rumen-v1_results.tsv',sep='\t')['sseqid'].tolist()
Rgut_phage = pd.read_csv('Prophage_blast_Rgut_results.tsv',sep='\t')['sseqid'].tolist()

def intersection(lst1, lst2):
    lst3 = [value for value in lst1 if value in lst2]
    return lst3

rumen_match = intersection(amg_contigs,rumen_phage)
Rgut_match = intersection(amg_contigs,Rgut_phage)

amg_host_rumen = rumen[rumen['sseqid'].isin(rumen_match)]
amg_host_Rgut = Rgut[Rgut['sseqid'].isin(Rgut_match)].drop_duplicates()

amg_host_rumen.to_csv('amg_host_rumen.tsv',sep='\t',index=None)
amg_host_Rgut.to_csv('amg_host_Rgut.tsv',sep='\t',index=None)