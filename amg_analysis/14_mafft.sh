#!/bin/bash
#SBATCH --job-name=cd_hit_dcd_%j
#SBATCH --output=cd_hit_dcd_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=00:10:00
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --account=PAS0439
#SBATCH --mail-type=ALL
#SBATCH --mail-user=yan1365,yan.1365@osu.edu

START=$SECONDS

cd  /fs/ess/PAS0439/MING/virome/amg_analysis/comparative_genomics_analysis/dcd

module load python/3.6-conda5.2
source activate /fs/ess/PAS0439/MING/conda/mafft

mafft dcd_for_msa.fasta > dcd_mafft.aln
DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
