#!/bin/bash
#SBATCH --job-name=iqtree_bacteria_host_%j
#SBATCH --output=iqtree_bacteria_host_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --account=PAS0439
#SBATCH --mail-type=ALL
#SBATCH --mail-user=yan1365,yan.1365@osu.edu

START=$SECONDS

cd  /fs/scratch/PAS0439/Ming/results/host_prediction/results/tree_node_connection/bacteria-gtdb-tk-out/

module load python/3.6-conda5.2
source activate /fs/ess/PAS0439/MING/conda/iqtree

iqtree -s gtdbtk.bac120.user_msa.fasta -redo -bb 1000 -m MFP -mset WAG,LG,JTT,Dayhoff -mrate E,I,G,I+G -mfreq FU -wbtl 
DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
