import pandas as pd
import numpy as np 
import os 

os.chdir('/fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/host_prediction/output')


spacer_match = pd.read_csv('rumen_final_spacer.tsv', sep = '\t' )
Species_rep = [id.split('_')[0] for id in spacer_match.qseqid]
spacer_match['Species_rep'] = Species_rep
#spacer_match.drop('qseqid', axis=1, inplace = True)

host =  pd.read_csv('../../../databases/mgnify-rumen-v1.0/genomes-all_metadata.tsv', sep = '\t')[['Species_rep', 'Lineage']]

taxa = pd.DataFrame(host.Lineage.str.split(';').tolist(), columns= [ 'domain', 'phylum', 'class', 'order', 'family', 'genus', 'specie'])

host_taxa = host.join(taxa)
host_taxa.drop_duplicates(subset=['Species_rep'], inplace=True)

mydata = pd.merge(spacer_match,host_taxa, on ='Species_rep')

mydata.to_csv('/fs/ess/PAS0439/MING/virome/host_prediction/MinCED/rumen_mgnify_results.csv', header=True, index=None )

number_host_match =  len(set(mydata['Species_rep'])) ## how many genomes in rumen-v1 database could be matched with spacer, 875
num_spacers_per_species = mydata.groupby(['Species_rep'])['qseqid'].count()
num_genome_per_species = mydata.groupby(['Species_rep'])['qseqid'].nunique()