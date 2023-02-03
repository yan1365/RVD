#!/bin/bash
#SBATCH --job-name=megablast_db_%j
#SBATCH --output=megablast_db_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --mail-type=ALL
#SBATCH --account=PAS0439

START=$SECONDS

module load python/3.6-conda5.2
source activate checkv 

cd /fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/keep1_keep2

blastn -query contigs_keep1_2_for_clustering.fa  -db myblast_db -outfmt '6 std qlen slen' -max_target_seqs 10000 -out myblast_db.tsv -num_threads 48


DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS