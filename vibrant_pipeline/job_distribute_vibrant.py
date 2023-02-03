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
    hours=math.ceil(nsamples_job*0.8)

    for file in range(len(splits)):
        start=splits[file][0]
        end=splits[file][-1]
        file_id=str(file+1).zfill(2)
        f = open(f'scratchs/vibrant/vibrant_{dataset}_{file_id}.sh' ,"w")
        f.write('''#!/bin/bash
#SBATCH --job-name=vibrant_{dataset}_%j
#SBATCH --output=vibrant_{dataset}_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time={hours}:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=48   ## require full node to avoid "out of memory error"
#SBATCH --account=PAS0439
#SBATCH --mail-type=ALL
#SBATCH --mail-user=yan1365,yan.1365@osu.edu


## {start} and {end} the sample id to be processed

echo "parameters used: start = {start}, end = {end}" 
START=$SECONDS

module load python/3.6-conda5.2
source activate vibrant-1.2.1

cd /fs/ess/PAS0439/MING/virome/assemblies_for_vibrant/{dataset}

for f in $(eval echo "{{{start}..{end}}}"); 
do



sample=$(basename $(find /fs/ess/PAS0439/MING/virome/assemblies_for_vibrant/{dataset}/ -name "${{f}}*"))
namebase=${{sample%.fa}}
echo "processing sample ${{sample}}"

VIBRANT_run.py -t 40 -i ${{sample}} -folder /fs/ess/PAS0439/MING/virome/virus_contigs/vibrant_pipeline/{dataset}/${{namebase}}_vibrant -l 5000

done

DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS'''.format(dataset=dataset, hours=hours, start=start, end=end))

        f.close()

if __name__ == "__main__":
    dataset = str(sys.argv[1])    
    njobs = int(sys.argv[2])
    distribute(dataset, njobs)