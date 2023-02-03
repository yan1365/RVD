#!/bin/bash
#SBATCH --job-name=virsorter2_%j
#SBATCH --output=virsorter2_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=5:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=48 
#SBATCH --account=PAS0439
#SBATCH --mail-type=ALL
#SBATCH --mail-user=yan1365,yan.1365@osu.edu


### load vs2 environment before submiting the job due to a module load error
## {dataset} ASS/mix/cattle/sheep

dataset=${1}
sample_index=${2}
   
START=$SECONDS

sample_id=$(basename $(find /fs/ess/PAS0439/MING/virome/assemblies/${dataset}/ -name "${sample_index}*"))
namebase=${sample_id%.fa.gz}
echo "processing sample ${sample_index} in dataset ${dataset}"


### If you prefer the full sequences (ending with ||full) not to be trimmed and leave it to specialized tools such as checkV, you can use --keep-original-seq option.
virsorter run --keep-original-seq -i /fs/ess/PAS0439/MING/virome/assemblies/${dataset}/${sample_id}   \
-w /fs/ess/PAS0439/MING/virome/virus_contigs/vs2_pipeline/vs2_pass1/${dataset}/${namebase}_vs2_pass1 --include-groups dsDNAphage,ssDNA --min-length 5000 --min-score 0.5 -j 48 all


DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS