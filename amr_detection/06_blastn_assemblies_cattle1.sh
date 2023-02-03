#!/bin/bash
#SBATCH --job-name=card_db_%j
#SBATCH --output=card_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=12:30:00
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --mail-type=ALL
#SBATCH --account=PAS0439

START=$SECONDS

cd /fs/scratch/PAS0439/Ming/assemblies/cattle

module load python/3.6-conda5.2
source activate checkv

for f in {001..150};
do i=$(ls ${f}*);
echo ${i}
#blastn -num_threads 48 -db /fs/scratch/PAS0439/Ming/databases/CARD/CARD_db -query ${i}  -outfmt 6 -evalue 1e-6 -out /fs/scratch/PAS0439/Ming/results/amr_results/CARD_blast/cattle/${i%fa}bln
done



DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS
