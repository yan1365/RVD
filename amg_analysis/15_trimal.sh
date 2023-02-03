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
source activate conda activate /fs/ess/PAS0439/MING/conda/trimal

trimal -in dcd_mafft.aln -out dcd_mafft_trimal.aln -gappyout
DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
