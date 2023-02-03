#!/bin/bash
#SBATCH --job-name=gtdbtk_%j
#SBATCH --output=gtdbtk_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=24:00:00
#SBATCH --nodes=1 
#SBATCH --ntasks-per-node=48 --partition=largemem
#SBATCH --account=PAS0439
#SBATCH --mail-type=ALL

module load python/3.6-conda5.2
source activate gtdbtk

cd /fs/scratch/PAS0439/Ming/results/host_prediction/results/tree_node_connection
gtdbtk classify_wf --genome_dir bacteria  --out_dir bacteria-gtdb-tk-out --cpus 48

DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS
