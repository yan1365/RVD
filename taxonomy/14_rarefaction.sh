#!/bin/bash
#SBATCH --job-name=rarefaction_%j
#SBATCH --output=rarefaction_%j.out
#SBATCH --ntasks-per-node=48 
#SBATCH --time=40:00:00 
#SBATCH --account PAS0439
#SBATCH --mail-type=ALL
#SBATCH --mail-user=yan1365,yan.1365@osu.edu

module load R/3.6.3-gnu9.1

cd /users/PAS1855/yan1365/R

R CMD BATCH rarefaction_rtk.R
#--partition=hugemem