#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=6
#SBATCH --time=90:00:00
#SBATCH --mem=64GB
#SBATCH --job-name=compare_methods
#SBATCH --mail-type=END,FAIL
#SBATCH --output=sbatch/out/compare_methods_${XMACHINE_REF}_${XMACHINE_TARGET}.out

cd /scratch/$USER/xmachine
module load r/intel/4.0.4
Rscript $PROJECT_NAME/R/sample_save.R