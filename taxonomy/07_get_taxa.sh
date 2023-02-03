#!/bin/bash
#SBATCH --job-name=get_taxa_%j
#SBATCH --output=get_taxa_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=10:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mail-type=ALL
#SBATCH --account=PAS0439

source activate entrez-direct
cd /fs/scratch/PAS0439/Ming/databases/refseq_virus/taxid_split

part=${1}

for f in $(cat taxid_${part}.txt)
do efetch -db taxonomy -id ${f} -format xml | \
xtract -pattern Taxon -first TaxId -element Taxon -block "*/Taxon"  \
-unless Rank -equals "no rank" -tab "," -sep "_" -element Rank,ScientificName
done > taxon_${part}.txt