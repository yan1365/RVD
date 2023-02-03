#!/bin/bash
#SBATCH --job-name=prodigal_%j
#SBATCH --output=prodigal_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=48 
#SBATCH --account=PAS0439
#SBATCH --mail-type=ALL
#SBATCH --mail-user=yan1365,yan.1365@osu.edu



module load python/3.6-conda5.2
source activate prodigal-2.6.3 

START=$SECONDS

dataset=${1}

cd /fs/ess/PAS0439/MING/virome/amg_analysis/AMG_host_metabolism/host_genome/${dataset}

for f in *.fna;
do 
prodigal -i ${f}  -a prodigal/${f%.fna}.faa
done


DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS