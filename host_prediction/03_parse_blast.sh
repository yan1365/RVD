#!/bin/bash

START=$SECONDS

module load python/3.6-conda5.2
source activate ipy-env

python 03_1_parse_blast.py  Rgut
python 03_1_parse_blast.py  rumen
python 03_1_parse_blast.py  refseq

DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
