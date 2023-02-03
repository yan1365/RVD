#!/usr/bin/env python

import pandas as pd 
import os
from Bio import SeqIO

os.chdir("/fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/keep1_keep2")

cluster = pd.read_csv("my_clusters.tsv", sep = '\t', header= None)
cluster.columns = ["vOTU", "contigs"]

def cal_n_contigs(row):
   n_contigs = len(row['contigs'].split(','))
   return n_contigs

cluster['n_contigs'] = cluster.apply(lambda row: cal_n_contigs(row), axis=1)

records = SeqIO.parse('contigs_keep1_2_for_clustering.fa' ,'fasta')
with open("contig_length_based_on_checkv.tsv", 'w') as file:
   file.write('contig_id' + '\t' + 'contig_length' + '\n')
   for record in records:
      file.write(record.name + '\t' + str(len(record.seq)) + '\n')
checkv = pd.read_csv("contig_length_based_on_checkv.tsv", sep = "\t")
mydf = pd.merge(cluster , checkv, left_on = "vOTU", right_on = "contig_id", right_index=False)
mydf.drop("contig_id",axis=1, inplace=True)
mydf.to_csv("my_clusters_summery.tsv", sep = "\t")


vOTU = list(mydf['vOTU'])

records =  SeqIO.parse("contigs_keep1_2_for_clustering.fa", 'fasta')
votu_fa = open("../vOTU/vOTU.fa","w")
for record in records:
   if record.name in vOTU:
      SeqIO.write(record, votu_fa, 'fasta')
      
votu_fa.close()

votu_10kb_fa = open("../vOTU/vOTU_10kb.fa","w") 
for record in records:
   if len(record.seq) >10000:
      SeqIO.write(record, votu_10kb_fa, 'fasta')
votu_10kb_fa.close()


