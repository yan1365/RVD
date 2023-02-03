#!/bin/bash
#SBATCH --job-name=Resfams_%j
#SBATCH --output=Resfams_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=10:30:00
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --mail-type=ALL
#SBATCH --account=PAS0439

START=$SECONDS


module load python/3.6-conda5.2
source activate /fs/ess/PAS0439/MING/conda/AMRFinder

hmmscan --cut_ga  --cpu 40 --tblout /fs/scratch/PAS0439/Ming/results/amr_results/Resfams/vcontigs_Resfams.out  /fs/scratch/PAS0439/Ming/databases/Resfams/Resfams.hmm /fs/ess/PAS0439/MING/virome/vOTU/contigs_keep1_2_proteins.faa 
 

DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS
