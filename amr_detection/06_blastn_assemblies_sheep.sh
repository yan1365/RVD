#!/bin/bash
#SBATCH --job-name=card_db_%j
#SBATCH --output=card_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=18:30:00
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --mail-type=ALL
#SBATCH --account=PAS0439

START=$SECONDS

cd /fs/scratch/PAS0439/Ming/assemblies/sheep 

module load python/3.6-conda5.2
source activate checkv

for f in *;
do blastn -num_threads 40 -db /fs/scratch/PAS0439/Ming/databases/CARD/CARD_db -query ${f}  -outfmt 6 -evalue 1e-6 -out /fs/scratch/PAS0439/Ming/results/amr_results/CARD_blast/sheep/${f%fa}bln
done



DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS
