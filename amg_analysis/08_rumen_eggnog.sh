#!/bin/bash
#SBATCH --job-name=eggnog_%j
#SBATCH --output=eggnog_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=6:30:00
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --account=PAS0439
#SBATCH --mail-type=ALL
#SBATCH --mail-user=yan1365,yan.1365@osu.edu

module load python/3.6-conda5.2
source activate /fs/ess/PAS0439/MING/conda/eggnog-mapper
cd /fs/ess/PAS0439/MING/virome/amg_analysis/AMG_host_metabolism/host_genome/rumen/prodigal
for f in *.faa
do
emapper.py  -m diamond -i ${f} --output  /fs/ess/PAS0439/MING/virome/amg_analysis/AMG_host_metabolism/eggnog_results/rumen/${f%.faa} --cpu 48 --data_dir /users/PAS0439/boyangzhangosu/.conda/envs/fastp/lib/python3.10/site-packages/data/
done

DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS
