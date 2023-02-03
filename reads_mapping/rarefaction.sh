#!/bin/bash
#SBATCH --job-name=rarefaction
#SBATCH --output=rarefaction.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=00:30:00
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --mail-type=ALL
#SBATCH --account=PAS0439

START=$SECONDS

module load python/3.6-conda5.2
source activate rtk 

cd /fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/ecology

rtk memory -i abundance_table_raw.tsv -o rarefaction/ -t 40        

DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS
