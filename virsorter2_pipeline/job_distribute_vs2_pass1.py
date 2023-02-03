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
    script = "virsorter2_pipeline/virsorter2_pass1.sh"
    nsamples = len(glob.glob(f"../assemblies/{dataset}/"+"*.gz")) 
    # glob.glob: return all file paths that match a specific pattern

    ls=[]
    for f in range(1, nsamples + 1):
        ls.append(str(f).zfill(3))

    njobs=math.ceil(nsamples/nsamples_job)
    splits = np.array_split(ls, njobs)
    hours=math.ceil(nsamples_job*1.5)

    for file in range(len(splits)):
        start=splits[file][0]
        end=splits[file][-1]
        file_id=str(file+1).zfill(2)
        f = open(f'scratchs/virsorter2_pass1_{dataset}_{file_id}.sh' ,"w")
        f.write('''#!/bin/bash
#SBATCH --job-name=virsorter2_{dataset}_%j
#SBATCH --output=virsorter2_{dataset}_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time={hours}:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --account=PAS0439

### load vs2 environment before submiting the job due to a module load error
## {start} and {end} the sample id to be processed

echo "parameters used: start = {start}, end = {end}" 
START=$SECONDS
for f in $(eval echo "{{{start}..{end}}}"); 
do


sample=$(basename $(find /fs/ess/PAS0439/MING/virome/assemblies/{dataset}/ -name "${{f}}*"))
namebase=${{sample%.fa.gz}}
echo "processing sample ${{sample}}"


### If you prefer the full sequences (ending with ||full) not to be trimmed and leave it to specialized tools such as checkV, you can use --keep-original-seq option.
virsorter run --keep-original-seq -i /fs/ess/PAS0439/MING/virome/assemblies/{dataset}/${{sample}}   \
-w /fs/ess/PAS0439/MING/virome/virus_contigs/vs2_pipeline/vs2_pass1/{dataset}/${{namebase}}_vs2_pass1 --include-groups dsDNAphage,ssDNA --min-length 5000 --min-score 0.5 -j 40 all
done

DURATION=$(( SECONDS - START ))

echo "Completed in $DURATION seconds."
sacct -j $SLURM_JOB_ID -o JobID,AllocTRES%50,Elapsed,CPUTime,TresUsageInTot,MaxRSS'''.format(dataset=dataset, hours=hours, start=start, end=end))

        f.close()

if __name__ == "__main__":
    dataset = str(sys.argv[1])    
    njobs = int(sys.argv[2])
    distribute(dataset, njobs)