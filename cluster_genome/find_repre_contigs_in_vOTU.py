import pandas as pd 
votu = pd.read_csv("../../vOTU/my_clusters.tsv", sep = "\t", header=None)
votu.columns = ["vOTU", "contigs"]

def cal_n_contigs(row):
   n_contigs = len(row['contigs'].split(','))
   return n_contigs

votu['n_contigs'] = votu.apply(lambda row: cal_n_contigs(row), axis=1)

checkv = pd.read_csv("../../vOTU/checkv_combine.tsv", sep = "\t", header=None)
checkv.columns = ["vOTU", "contigs_length"]






