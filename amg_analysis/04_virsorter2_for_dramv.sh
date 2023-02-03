#!/bin/bash
#SBATCH --job-name=virsorter2_%j
#SBATCH --output=virsorter2_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=2:30:00
#SBATCH --nodes=1
#SBATCH --ntasks=48 
#SBATCH --account=PAS0439
#SBATCH --mail-type=ALL
#SBATCH --mail-user=yan1365,yan.1365@osu.edu

### load vs2 environment before submiting the job due to a module load error

START=$SECONDS
part=${1}

cd /fs/ess/PAS0439/MING/virome/amg_analysis/complete_viruses_splited

virsorter run --seqname-suffix-off --viral-gene-enrich-off --provirus-off --prep-for-dramv -w ../dram_annotation/${part} -i complete_viruses.part_${part}.fa -j 48 all

DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS