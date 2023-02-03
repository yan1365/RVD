#!/bin/bash
#SBATCH --job-name=blastp_refseq_virus_%j
#SBATCH --output=blastp_refseq_virus_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=12:30:00
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --mail-type=ALL
#SBATCH --account=PAS0439

START=$SECONDS

cd /fs/scratch/PAS0439/Ming/databases/refseq_virus/refseq_viral_protein_db

module load python/3.6-conda5.2
source activate checkv

part=${1}

blastp -num_threads 40 -db refseq_viral_protein_db  -query /fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/taxonomy/votu_for_blastp_split/votu_for_blastp.part_${part}.faa  -evalue  0.001 -out /fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/taxonomy/output/refseq_virus_${part}.bln -outfmt "6 qseqid sseqid pident length qlen slen mismatch gapopen qstart qend sstart send evalue bitscore"


DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS
