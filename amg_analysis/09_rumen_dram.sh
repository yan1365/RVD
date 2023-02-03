#!/bin/bash
#SBATCH --job-name=dram_rumen_%j
#SBATCH --output=dram_rumen_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=48 
#SBATCH --account=PAS0439
#SBATCH --mail-type=ALL
#SBATCH --mail-user=yan1365,yan.1365@osu.edu


module load python/3.6-conda5.2
source activate dram

START=$SECONDS

cd /fs/ess/PAS0439/MING/virome/amg_analysis/AMG_host_metabolism/host_genome/rumen

DRAM.py annotate -i '*.fna' -o ../../dram_res/rumen/annotation
DRAM.py distill -i ../../dram_res/rumen/annotation/annotations.tsv -o ../../dram_res/rumen/genome_summaries --trna_path ../../dram_res/rumen/annotation/trnas.tsv --rrna_path ../../dram_res/rumen/annotation/rrnas.tsv

DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS