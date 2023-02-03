#!/bin/bash
#SBATCH --job-name=cbr_%j
#SBATCH --output=cbr_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=10:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mail-type=ALL
#SBATCH --account=PAS0439
#SBATCH --mail-user=yan1365,yan.1365@osu.edu


file=$1
for f in $(cat ${file})
do 
echo ${f};
pigz -dc /fs/scratch/PAS0439/lzj/CBR_reads/${f}_1.fq.gz|awk '!/^>|^+|^+/'|wc -c; 
pigz -dc /fs/scratch/PAS0439/lzj/CBR_reads/${f}_1.fq.gz|awk '!/^>|^+|^+/'|wc -l;
pigz -dc /fs/scratch/PAS0439/lzj/CBR_reads/${f}_2.fq.gz|awk '!/^>|^+|^+/'|wc -c;
pigz -dc /fs/scratch/PAS0439/lzj/CBR_reads/${f}_2.fq.gz|awk '!/^>|^+|^+/'|wc -l;
done