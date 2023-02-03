#!/bin/bash
#SBATCH --job-name=prophage_blast_%j
#SBATCH --output=prophage_blast_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=00:30:00
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --mail-type=ALL
#SBATCH --account=PAS0439

START=$SECONDS
cd /fs/scratch/PAS0439/Ming/databases/52SAG_lzj

module load python/3.6-conda5.2
source activate checkv

sag=${1}

blastn -task megablast -query ${sag} -db /fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/host_prediction/vOTU_blast_db/vOTU_blast_db -out /fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/host_prediction/protozoa_prophage_blast/${sag%.fa}.bln -num_threads 40 -evalue 0.001 -outfmt "6 qseqid sseqid pident length qlen slen mismatch gapopen qstart qend sstart send evalue bitscore"


DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS