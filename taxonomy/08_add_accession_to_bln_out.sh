#!/bin/bash
#SBATCH --job-name=get_taxa_%j
#SBATCH --output=get_taxa_%j.out
# Walltime Limit: hh:mm:ss 
#SBATCH --time=10:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=10
#SBATCH --mail-type=ALL
#SBATCH --account=PAS0439

source activate  /fs/ess/PAS0439/MING/conda/MYENV

python add_accession_to_bln_out.py  

