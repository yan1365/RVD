#!/bin/bash
#SBATCH --job-name=diamond_%j
#SBATCH --output=diamond_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=10:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --mail-type=ALL
#SBATCH --account=PAS0439
#SBATCH --mail-user=yan1365,yan.1365@osu.edu


cd /fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/taxonomy/vOTU_10kb_vs2_vibrant_intersection

START=$SECONDS


module load python/3.6-conda5.2
source activate prodigal-2.6.3
part=${1}
prodigal -i vOTU_10kb_vs2_vibrant_intersection.part_${part}.fa  -p meta -a ../diamond/vOTU_10kb_vs2_vibrant_intersection.part_${part}.faa

DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS