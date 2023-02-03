#!/bin/bash
#SBATCH --job-name=blastn_refseq_%j
#SBATCH --output=blastn_refseq_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=00:30:00
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --mail-type=ALL
#SBATCH --account=PAS0439

START=$SECONDS

cd /fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/vOTU

module load python/3.6-conda5.2
source activate checkv

makeblastdb -in vOTU_vs2_vibrant_intersection.fa -dbtype nucl -out ../host_prediction/vOTU_blast_db/vOTU_blast_db

DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS
