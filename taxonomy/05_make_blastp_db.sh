#!/bin/bash
#SBATCH --job-name=make_blastpdb_%j
#SBATCH --output=make_blastpdb_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=4:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --mail-type=ALL
#SBATCH --account=PAS0439
#SBATCH --mail-user=yan1365,yan.1365@osu.edu


cd /fs/scratch/PAS0439/Ming/databases/refseq_virus/refseq_viral_protein_db

START=$SECONDS

module load python/3.6-conda5.2
source activate checkv

makeblastdb -in  refseq_viral_protein_combined.faa   -dbtype prot -out refseq_viral_protein_db


DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS