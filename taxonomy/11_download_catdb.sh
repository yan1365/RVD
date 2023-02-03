#!/bin/bash
#SBATCH --job-name=download_catdb_%j
#SBATCH --output=download_catdb_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=10:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mail-type=ALL
#SBATCH --account=PAS0439
#SBATCH --mail-user=yan1365,yan.1365@osu.edu

START=$SECONDS

cd /fs/scratch/PAS0439/Ming/databases/CAT

wget https://tbb.bio.uu.nl/bastiaan/CAT_prepare/CAT_prepare_20210107.tar.gz

DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
