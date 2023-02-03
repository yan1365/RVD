#!/bin/bash
#SBATCH --job-name=mmseq2_%j
#SBATCH --output=mmseq2_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=00:10:00
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --account=PAS0439
#SBATCH --mail-type=ALL
#SBATCH --mail-user=yan1365,yan.1365@osu.edu

START=$SECONDS

cd  /fs/ess/PAS0439/MING/virome/amg_analysis/comparative_genomics_analysis/cazy/GH2_8_10_16/protein_grouping

module load python/3.6-conda5.2
source activate mmseqs2

mmseqs createdb total_protein.faa total_protein_db
mmseqs cluster total_protein_db total_protein_clu /fs/scratch/PAS0439/Ming/tmp  --min-seq-id 0.3 -c 0.6 -s 7.5 -e 0.001
mmseqs createtsv total_protein_db total_protein_db total_protein_clu total_protein_clu.tsv

DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
