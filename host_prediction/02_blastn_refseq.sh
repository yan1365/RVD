#!/bin/bash
#SBATCH --job-name=blastn_refseq_%j
#SBATCH --output=blastn_refseq_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=00:30:00
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --mail-type=ALL
#SBATCH --account=PAS0439

START=$SECONDS

cd /fs/scratch/PAS0439/Ming/results/host_prediction/minced/refseq

module load python/3.6-conda5.2
source activate checkv

blastn -num_threads 48 -db  /fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/host_prediction/vOTU_blast_db/vOTU_blast_db -query refseq_spacers.fa -dust no -qcov_hsp_perc 100  -outfmt 6 -evalue 1e-6 -out /fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/host_prediction/spacer_out/vOTU_vs_refseq_spacers.bln




DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS
