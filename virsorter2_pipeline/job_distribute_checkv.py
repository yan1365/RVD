#!/usr/bin/env python
import os 
import numpy as np
import glob
import sys
import math

def distribute(dataset, nsamples_job):
    """
    Seperate and distribute jobs based on {nsamples_job} set, namely number of samples per job
    """
     
    
    os.chdir("/fs/ess/PAS0439/MING/virome/scripts")
    nsamples = len(glob.glob(f"../assemblies/{dataset}/"+"*.gz")) 
    # glob.glob: return all file paths that match a specific pattern

    ls=[]
    for f in range(1, nsamples + 1):
        ls.append(str(f).zfill(3))

    njobs=math.ceil(nsamples/nsamples_job)
    splits = np.array_split(ls, njobs)
    hours=math.ceil(nsamples_job*0.15)

## math.ceil(): The math.ceil() method rounds a number UP to the nearest integer, if necessary, and returns the result. Opposite to math.floor().

    for file in range(len(splits)):
        start=splits[file][0]
        end=splits[file][-1]
        file_id=str(file+1).zfill(2)
        f = open(f'scratchs/checkv/checkv_{dataset}_{file_id}.sh' ,"w")
        f.write('''#!/bin/bash
#SBATCH --job-name=checkv_{dataset}_%j
#SBATCH --output=checkv_{dataset}_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time={hours}:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=48   
#SBATCH --account=PAS0439
#SBATCH --mail-type=ALL
#SBATCH --mail-user=yan1365,yan.1365@osu.edu


## {start} and {end} the sample id to be processed

echo "parameters used: start = {start}, end = {end}" 
START=$SECONDS

module load python/3.6-conda5.2
source activate checkv

cd /fs/ess/PAS0439/MING/virome/virus_contigs/vs2_pipeline/vs2_pass1/{dataset}

for f in $(eval echo "{{{start}..{end}}}"); 
do

sample=$(basename $(find -name "${{f}}*"))
echo "processing dataset {dataset}, sample ${{sample}}"

checkv end_to_end -t 48 ./${{sample}}/final-viral-combined.fa  /fs/scratch/PAS0439/Ming/results/virus_identification/virsorter2_pipeline/checkv_res/{dataset}/{dataset}_${{sample%_vs2_pass1}}  -d /fs/ess/PAS0439/MING/databases/checkv-db-v1.0

done

DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS'''.format(dataset=dataset, hours=hours, start=start, end=end))

        f.close()

if __name__ == "__main__":
    dataset = str(sys.argv[1])    
    njobs = int(sys.argv[2])
    distribute(dataset, njobs)