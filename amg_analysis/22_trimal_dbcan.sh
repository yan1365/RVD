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

cd  /fs/scratch/PAS0439/Ming/results/dbcan_res/tree/

module load python/3.6-conda5.2
source activate /fs/ess/PAS0439/MING/conda/trimal

#trimal -in gh10/gh10_mafft.aln -out gh10/gh10_mafft_trimal.aln -gappyout
trimal -in gh16/gh16_mafft.aln -out gh16/gh16_mafft_trimal.aln -gappyout

DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
