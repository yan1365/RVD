#!/bin/bash
#SBATCH --job-name=dramv_%j
#SBATCH --output=dramv_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=10:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=48 
#SBATCH --account=PAS0439
#SBATCH --mail-type=ALL
#SBATCH --mail-user=yan1365,yan.1365@osu.edu


module load python/3.6-conda5.2
source activate dram

START=$SECONDS

cd /fs/scratch/PAS0439/Ming/results/amr_results/dramv

DRAM-v.py annotate -i for_dramv/for-dramv/final-viral-combined-for-dramv.fa  -v for_dramv/for-dramv/viral-affi-contigs-for-dramv.tab -o annotation
DRAM-v.py distill -i annotation/annotations.tsv -o distill


DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS