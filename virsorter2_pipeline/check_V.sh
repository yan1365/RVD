#!/bin/bash
#SBATCH --job-name=checkv_%j
#SBATCH --output=checkv_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=00:30:00
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --mail-type=ALL
#SBATCH --account=PAS0439

START=$SECONDS
dataset=${1}
sample_id=${2}

module load python/3.6-conda5.2
source activate checkv 

cd /fs/ess/PAS0439/MING/virome/virus_contigs/vs2_pipeline/vs2_pass1/${dataset}
sample=$(basename $(find -name "${sample_id}*"))

checkv end_to_end -t 40 ./${sample}/final-viral-combined.fa  /fs/scratch/PAS0439/Ming/results/virus_identification/virsorter2_pipeline/checkv_res/${dataset}/${dataset}_${sample%_vs2_pass1}   -d /fs/ess/PAS0439/MING/databases/checkv-db-v1.0


DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS