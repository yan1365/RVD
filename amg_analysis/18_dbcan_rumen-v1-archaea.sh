#!/bin/bash
#SBATCH --job-name=dbcan_rumen-v1-archaea_%j
#SBATCH --output=dbcan_rumen-v1-archaea_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=2:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --account=PAS0439
#SBATCH --mail-type=ALL
#SBATCH --mail-user=yan1365,yan.1365@osu.edu

START=$SECONDS

cd  /fs/scratch/PAS0439/Ming/databases/mgnify-rumen-v1.0/genomes/archaea

module load python/3.6-conda5.2
source activate /fs/ess/PAS0439/MING/conda/run_dbcan

for f in *;
do run_dbcan ${f} prok --out_dir /fs/scratch/PAS0439/Ming/results/dbcan_res/rumen-v1 -t hmmer --hmm_cpu 48  --db_dir /fs/ess/PAS0439/MING/conda/run_dbcan/db  --out_pre ${f%.fna}_
done
DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
