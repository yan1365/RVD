#!/bin/bash
#SBATCH --job-name=coverm_imgvr_%j
#SBATCH --output=coverm_imgvr_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=1:30:00
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --mail-type=ALL
#SBATCH --account=PAS0439

START=$SECONDS
file=$1

module load python/3.6-conda5.2
source activate /users/PAS1855/yan1365/miniconda3/envs/coverm-0.6.1


for f in $(cat ${file});
do  coverm contig --coupled /fs/scratch/PAS0439/Ming/virome_ecology_core_prkaryotes/clean_reads/${f} /fs/scratch/PAS0439/Ming/virome_ecology_core_prkaryotes/clean_reads/${f%_1.fq.gz}_2.fq.gz --reference /fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/vOTU/vOTU_vs2_vibrant_intersection.fa --min-read-percent-identity 0.95 --min-read-aligned-percent 0.75 --min-covered-fraction 0.7 -m trimmed_mean --bam-file-cache-directory /fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/AMR/bam_tmp --discard-unmapped -t 20 > /fs/scratch/PAS0439/Ming/virome_ecology_core_prkaryotes/results/tmp/${f%_1.fq.gz}.txt
done
DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS
