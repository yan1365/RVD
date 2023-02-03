#!/bin/bash
#SBATCH --job-name=uclust_%j
#SBATCH --output=uclust_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=00:30:00
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --mail-type=ALL
#SBATCH --account=PAS0439

START=$SECONDS

module load python/3.6-conda5.2
source activate checkv 

cd /fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/keep1_keep2

python ../scripts/cluster_genome/aniclust.py --fna contigs_keep1_2_for_clustering.fa --ani my_ani.tsv --out my_clusters.tsv --min_ani 95 --min_tcov 85 --min_qcov 0


DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS