#!/bin/bash
#SBATCH --job-name=cal_ani_%j
#SBATCH --output=cal_ani_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=01:30:00
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --mail-type=ALL
#SBATCH --account=PAS0439

START=$SECONDS

module load python/3.6-conda5.2
source activate checkv 

cd /fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/keep1_keep2

python ../scripts/cluster_genome/anicalc.py -i myblast_db.tsv -o my_ani.tsv


DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS