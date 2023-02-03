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

part=${1}

module load python/3.6-conda5.2
source activate dram

START=$SECONDS

cd /fs/ess/PAS0439/MING/virome/amg_analysis/dram_annotation/${part}

DRAM-v.py annotate -i for-dramv/final-viral-combined-for-dramv.fa  -v for-dramv/viral-affi-contigs-for-dramv.tab -o annotation
DRAM-v.py distill -i annotation/annotations.tsv -o distill


DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS