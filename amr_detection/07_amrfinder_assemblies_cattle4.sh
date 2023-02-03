#!/bin/bash
#SBATCH --job-name=amrfinder_%j
#SBATCH --output=amrfinder_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=14:30:00
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --mail-type=ALL
#SBATCH --account=PAS0439

START=$SECONDS

cd /fs/scratch/PAS0439/Ming/assemblies/cattle

module load python/3.6-conda5.2
source activate /fs/ess/PAS0439/MING/conda/AMRFinder

for f in {181..240};
do i=$(ls ${f}*);
amrfinder -n ${i}  -o /fs/scratch/PAS0439/Ming/results/amr_results/amr_finder/cattle/${i%.fa}_amrfinder.out --threads 40
done 

DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS
