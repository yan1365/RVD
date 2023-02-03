#!/bin/bash
#SBATCH --job-name=blastp_%j
#SBATCH --output=blastp_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=00:30:00
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --mail-type=ALL
#SBATCH --account=PAS0439

START=$SECONDS

cd /fs/scratch/PAS0439/Ming/results/dbcan_res

module load python/3.6-conda5.2
source activate checkv

makeblastdb -in rumen_gh10.fasta  -dbtype prot -out rumen_gh10_blast_db
makeblastdb -in rumen_gh16.fasta  -dbtype prot -out rumen_gh16_blast_db

blastp -num_threads 48 -db rumen_gh10_blast_db -query /fs/ess/PAS0439/MING/virome/amg_analysis/comparative_genomics_analysis/cazy/GH2_8_10_16/tree/GH10/GH10.fasta  -outfmt 6 -evalue 1e-6 -out rumen_gh10.bln
blastp -num_threads 48 -db rumen_gh16_blast_db -query /fs/ess/PAS0439/MING/virome/amg_analysis/comparative_genomics_analysis/cazy/GH2_8_10_16/tree/GH16/GH16.fasta -outfmt 6 -evalue 1e-6 -out rumen_gh16.bln


DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS
