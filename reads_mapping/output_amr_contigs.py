#!/fs/ess/PAS0439/MING/conda/MYENV/bin/python

import os
import glob
import pandas as pd
import numpy as np

os.chdir('/fs/scratch/PAS0439/Ming/results/amr_results/CARD_blast/rumen_metagenome')

vcontigs = pd.read_csv('../../CARD_metagenomes.tsv' ,sep ='\t')
os.chdir('/fs/scratch/PAS0439/Ming/results/amr_results/amr_finder')
amrfinder_res = glob.glob('./**/*_amrfinder.out')
amrfinder_dict = {}

for f in amrfinder_res:
    sample = f.split('_')[1]
    if os.stat(f).st_size == 0:
        continue
    else:
        amrfinder_list = list(pd.read_csv(f, sep='\t')['Contig id'])
        amrfinder_dict[sample] = amrfinder_list

for index, row in vcontigs.iterrows():
    
    sample = row['qseqid'].split('_')[0]
    contig = row['qseqid'].split('_')[0] + '_' + row['qseqid'].split('_')[1]
    
    vcontigs.loc[index, 'sample'] = sample
    vcontigs.loc[index, 'contig'] = contig

card_dict = {}
for f in set(vcontigs['sample']):
    _ = list(vcontigs.query('sample == @f')['contig'])
    card_dict[f] = _
    
amr_dict = {}
samples = list(card_dict.keys())
for f in samples:
    if f in amrfinder_dict.keys():
        _ = set(card_dict[f]).union(set(amrfinder_dict[f]))
        amr_dict[f] = _
    else:
        _ = set(card_dict[f])
        amr_dict[f] = _

for key in amr_dict.keys():
    sample = key
    with open(f'/fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/ecology/metagenome_mapping/{sample}.txt', 'w') as file:
        for contig in amr_dict[key]:
            file.write(contig + '\n')

from Bio import SeqIO
os.chdir('/fs/scratch/PAS0439/Ming/assemblies')
assemblies = glob.glob('*')
for f in assemblies:
    sample = f.split('.fa')[0]
    with open(f'/fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/ecology/metagenome_mapping/contig_abundance/{sample}.fa', 'w') as file:
        records = SeqIO.parse(f, 'fasta')
        contigs = amr_dict[sample]
        for record in records:
            
            if record.name in contigs:
                SeqIO.write(record, file, 'fasta')
        