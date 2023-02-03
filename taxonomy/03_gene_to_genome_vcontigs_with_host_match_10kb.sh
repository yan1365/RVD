#!/bin/bash
#SBATCH --job-name=gene_to_genome_%j
#SBATCH --output=gene_to_genome_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=10:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --mail-type=ALL
#SBATCH --account=PAS0439
#SBATCH --mail-user=yan1365,yan.1365@osu.edu
module load python/3.6-conda5.2
source deactivate
source activate vs2


cd /fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/taxonomy/diamond

START=$SECONDS
part=${1}

python ../../scripts/taxonomy/vcontact2_gene2genome.py -p vOTU_10kb_vs2_vibrant_intersection.part_${part}.faa    -o ../vcontact2/vOTU_10kb_vs2_vibrant_intersection.part_${part}.csv -s Prodigal-FAA
DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS