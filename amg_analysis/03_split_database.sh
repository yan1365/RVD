#!/bin/bash
START=$SECONDS

module load python/3.6-conda5.2
source activate seqkit 

cd /fs/ess/PAS0439/MING/virome/amg_analysis/
seqkit split2 complete_viruses.fa  -p 40 -O complete_viruses_splited -f

DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
