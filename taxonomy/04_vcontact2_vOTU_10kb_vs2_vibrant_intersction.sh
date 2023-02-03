#!/bin/bash
#SBATCH --job-name=vcontact2_${part}_%j
#SBATCH --output=vcontact2_${part}_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=4-00:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=48 --partition=largemem
#SBATCH --mail-type=ALL
#SBATCH --account=PAS0439
#SBATCH --mail-user=yan1365,yan.1365@osu.edu

module load python/3.6-conda5.2
source activate /fs/scratch/PAS0439/Ming/conda/vcontact-0.9.19-0.25.1-np1.15.4


cd /fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/taxonomy/vcontact2

START=$SECONDS
part=${1}
  
vcontact2  -r ../diamond/vOTU_10kb_vs2_vibrant_intersection.part_${part}.faa --rel-mode 'Diamond' -p vOTU_10kb_vs2_vibrant_intersection.part_${part}.csv --db ProkaryoticViralRefSeq201-Merged  --output-dir /fs/scratch/PAS0439/Ming/virome_res/vcontact2_out/part_${part} --c1-bin /fs/ess/PAS0439/MING/virome/scripts/taxonomy_classification/cluster_one-1.0.jar --pcs-mode MCL --vcs-mode ClusterONE -t 48 -f

DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS