#!/bin/bash
#SBATCH --job-name=cd_hit_%j
#SBATCH --output=cd_hit_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=00:01:00
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --account=PAS0439
#SBATCH --mail-type=ALL
#SBATCH --mail-user=yan1365,yan.1365@osu.edu

START=$SECONDS

cd  /fs/scratch/PAS0439/Ming/results/dbcan_res/tree/

module load python/3.6-conda5.2
source activate /fs/ess/PAS0439/MING/conda/cd-hit

#cd-hit -i gh10/rumen_gh10_for_cd_hit.fasta -o gh10/rumen_gh10_clus70.fasta -c 0.70 -n 5  -M 1600000 -d 0 -T 48 
#cd-hit -i gh16/rumen_gh16_for_cd_hit.fasta -o gh16/rumen_gh16_clus70.fasta -c 0.70 -n 5  -M 1600000 -d 0 -T 48 

cd-hit -i gh10/rumen_nr_combined_gh10_for_cdhit.fasta -o gh10/nr_gh10_clus70.fasta -c 0.70 -n 5  -M 1600000 -d 0 -T 48 
cd-hit -i gh16/rumen_nr_combined_gh16_for_cdhit.fasta -o gh16/nr_gh16_clus70.fasta -c 0.70 -n 5  -M 1600000 -d 0 -T 48

DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
