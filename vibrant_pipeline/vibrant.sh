#!/bin/bash
#SBATCH --job-name=vibrant_%j
#SBATCH --output=vibrant_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=48:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=48 --partition=largemem
#SBATCH --mail-type=ALL
#SBATCH --account=PAS0439


START=$SECONDS

module load python/3.6-conda5.2
source activate vibrant-1.2.1

cd /fs/ess/PAS0439/MING/virome

VIBRANT_run.py -no_plot  -virome -t 40 -i vOTU/contigs_keep1_2_for_clustering.fa -folder vibrant_out 

DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS