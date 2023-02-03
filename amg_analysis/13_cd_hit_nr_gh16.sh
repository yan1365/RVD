#!/bin/bash
#SBATCH --job-name=cd_hit_dcd_%j
#SBATCH --output=cd_hit_dcd_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=00:01:00
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --account=PAS0439
#SBATCH --mail-type=ALL
#SBATCH --mail-user=yan1365,yan.1365@osu.edu

START=$SECONDS

cd  /fs/ess/PAS0439/MING/virome/amg_analysis/comparative_genomics_analysis/cazy/GH2_8_10_16/tree/GH16

module load python/3.6-conda5.2
source activate /fs/ess/PAS0439/MING/conda/cd-hit

cd-hit -i GH16_for_cd_hit.fasta -o GH16_nr_50.fasta -c 0.5 -n 3  -M 1600000 -d 0 -T 48 

DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
