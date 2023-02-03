#!/bin/bash 
START=$SECONDS

module load python/3.6-conda5.2
source activate seqkit 

cd /fs/ess/PAS0439/MING/virome/checkv_trimmed_for_dowmstream/vOTU
seqkit split2 vOTU_10kb_vs2_vibrant_intersection.fa  -p 10 -O ../taxonomy/vOTU_10kb_vs2_vibrant_intersection -f

DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
