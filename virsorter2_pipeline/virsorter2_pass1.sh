#!/bin/bash
#SBATCH --job-name=virsorter2_%j
#SBATCH --output=virsorter2_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --mem=177gb #Pitzer is 177, Owens is 115
#SBATCH --mail-type=ALL
#SBATCH --account=PAS0439



### load vs2 environment before submiting the job due to a module load error
## {dataset} ASS/mix/cattle/sheep
## {start} and {end} the sample id to be processed

dataset=${1}
start=${2}
end=${3}
echo "parameters used: dataset = ${dataset}, start = ${start}, end = ${end}" 
START=$SECONDS

for f in $(eval echo "{$start..$end}");
do 
sample=$(basename $(find /fs/ess/PAS0439/MING/virome/assemblies/${dataset}/ -name "${f}*"))
namebase=${sample%.fa.gz}
echo "processing sample ${sample}"


### If you prefer the full sequences (ending with ||full) not to be trimmed and leave it to specialized tools such as checkV, you can use --keep-original-seq option.
virsorter run --keep-original-seq -i /fs/ess/PAS0439/MING/virome/assemblies/${dataset}/${sample}   \
-w /fs/ess/PAS0439/MING/virome/virus_contigs/vs2_pipeline/vs2_pass1/${namebase}_vs2_pass1 --include-groups dsDNAphage,ssDNA --min-length 5000 --min-score 0.5 -j 40 all

done

DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS