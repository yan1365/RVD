#!/bin/bash
#SBATCH --job-name=diamond_%j
#SBATCH --output=diamond_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=48:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --mail-type=ALL
#SBATCH --account=PAS0439
#SBATCH --mail-user=yan1365,yan.1365@osu.edu


cd /fs/ess/PAS0439/MING/virome/vOTU

START=$SECONDS


module load python/3.6-conda5.2
source activate prodigal-2.6.3

prodigal -i contigs_keep1_2_for_clustering.fa  -p meta -a contigs_keep1_2_proteins.faa

DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS