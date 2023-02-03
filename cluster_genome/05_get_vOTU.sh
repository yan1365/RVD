#!/bin/bash
#SBATCH --job-name=get_vOTU_%j
#SBATCH --output=get_vOTU_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=03:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --mail-type=ALL
#SBATCH --account=PAS0439

START=$SECONDS

module load python/3.6-conda5.2
source activate ipy-env 

cd /fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/scripts/cluster_genome

python cluster_summary_and_output_vOTU.py 


DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS