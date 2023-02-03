#!/bin/bash

START=$SECONDS
dataset=${1}


module load python/3.6-conda5.2
source activate seqkit 

cd /fs/ess/PAS0439/MING/virome/virus_contigs_keep1_2/${dataset}

for f in *;
do 
sample=$(basename $(find -name "${f}"))
cat ${sample} | seqkit seq -m 10000 > /fs/ess/PAS0439/MING/virome/amg_analysis/virus_contigs_10kb/${dataset}/${sample%.fa}_10kb.fa
done

DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
