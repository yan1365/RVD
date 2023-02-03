#!/bin/bash
#SBATCH --job-name=coverm
#SBATCH --output=coverm.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=12:30:00
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --mail-type=ALL
#SBATCH --account=PAS0439

START=$SECONDS

module load python/3.6-conda5.2
source activate /users/PAS1855/yan1365/miniconda3/envs/coverm-0.6.1


file=${1}
for f in $(cat ${file});
do  coverm contig --coupled /fs/scratch/PAS0439/lzj/sheep_reads/${f}_1.fq.gz /fs/scratch/PAS0439/lzj/sheep_reads/${f}_2.fq.gz --reference /fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/AMG/amg_containing_contigs.fa --min-read-percent-identity 0.95 --min-read-aligned-percent 0.75 --min-covered-fraction 0.7 -m trimmed_mean --bam-file-cache-directory /fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/AMG/bam_tmp --discard-unmapped -t 20 > /fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/AMG/sheep/${f}.txt
done
DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS
