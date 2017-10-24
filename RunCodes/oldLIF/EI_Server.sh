#!/bin/bash
#SBATCH --nodes=1
#SBATCH --array=1-441
#SBATCH --cpus-per-task=2
#SBATCH --time=24:00:00
#SBATCH --mem=10GB
#SBATCH --job-name=EIBalance
#SBATCH --mail-type=ALL
#SBATCH --mail-user=jmg1030@nyu.edu
#SBATCH --output=EI_balance%j.out

i=${SLURM_ARRAY_TASK_ID}

module purge
module load matlab/2017a

echo "EIBalance($i); exit;" | matlab -nodisplay

echo "Done"
