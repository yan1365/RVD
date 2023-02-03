import os 
import pandas as pd 
import numpy as np
from functools import reduce


def get_true_amg(part):
    
    os.chdir(f'/fs/ess/PAS0439/MING/virome/amg_analysis/dram_annotation/{part}')
    distill = pd.read_csv('distill/amg_summary.tsv', sep = '\t')
    distill.rename(columns={'scaffold': 'virus_contig'}, inplace=True)
    distill.virus_contig = distill.virus_contig.str.replace('-.*','', regex = True)

    annotation = pd.read_csv('annotation/annotations.tsv', sep = '\t')
    annotation.rename(columns={'Unnamed: 0': 'gene',"fasta": "virus_contig"}, inplace=True)
    annotation.virus_contig = annotation.virus_contig.str.replace('-.*','', regex = True)

    summary = pd.read_csv('final-viral-score.tsv', sep = '\t')
    summary.rename(columns = {'seqname': 'virus_contig'}, inplace = True)
    summary.virus_contig = summary.virus_contig.str.replace('||','__', regex = False)

    vMAG = pd.read_csv('distill/vMAG_stats.tsv', sep = '\t')
    vMAG.rename(columns={"Unnamed: 0": "virus_contig","potential AMG count": 'AMG_count', 'Gene count': 'gene_count', 'Transposase present': 'Transposase_present','Viral hypothetical genes': 'Viral_hypothetical_genes', 'Viral replication genes':'Viral_replication_genes','Viral structure genes': 'Viral_structure_genes'}, inplace=True)
    vMAG.virus_contig = vMAG.virus_contig.str.replace('-.*','', regex = True)

    hallmark = summary.query('hallmark > 0')['virus_contig']
    non_transposase = vMAG.query('AMG_count > 0').query('Transposase_present == False')['virus_contig']
    dramv_not_F_flag = distill[-distill.amg_flags.str.contains('F')].query('auxiliary_score == 2 |auxiliary_score == 1')['virus_contig']
    dramv_F_flag = distill[distill.amg_flags.str.contains('F')].query('auxiliary_score == 2 |auxiliary_score == 1')['virus_contig']
    secretion_system = annotation[annotation.apply(lambda r: r.astype(str).str.contains('secretion system').any(), axis=1)]['virus_contig']

    true_amg = list(reduce(np.intersect1d, [hallmark, non_transposase, dramv_not_F_flag]))
    manual_curation_F_flag = set(list(reduce(np.intersect1d, [hallmark, non_transposase, dramv_F_flag])))
    manual_curation_secretion_system = set(list(reduce(np.intersect1d, [hallmark, non_transposase, secretion_system])))

    return true_amg, manual_curation_F_flag, manual_curation_secretion_system
    
amg = []
for f in range(1,41):
    part = str(f).zfill(3)
    a,b,c = get_true_amg(part)
    amg.extend(a)
    if len(b) > 0 :
        with open(f"/fs/ess/PAS0439/MING/virome/amg_analysis/manual_curation/manual_check_F_flag_{part}.txt",'w') as infile1:
            for f in b:
                infile1.write(f + '\n')

    if len(c) > 0 :
        with open(f"/fs/ess/PAS0439/MING/virome/amg_analysis/manual_curation/manual_check_secretion_system_{part}.txt",'w') as infile2:
            for f in c:
                infile2.write(f + '\n')

with open("/fs/ess/PAS0439/MING/virome/amg_analysis/manual_curation/true_amg.txt",'w') as infile:
    for f in amg:
        infile.write(f + '\n')



