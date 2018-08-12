#!/bin/bash
#SBATCH --nodes=1
#SBATCH --array=1-4
#SBATCH --cpus-per-task=36
#SBATCH --time=12:00:00
#SBATCH --mem=200GB
#SBATCH --job-name=FI_LogWeight
#SBATCH --mail-type=END
#SBATCH --mail-user=jmg1030@nyu.edu
#SBATCH --output=FI_LogWeight_%j.out

n=${SLURM_ARRAY_TASK_ID}

module purge
module load matlab/2018a

echo "CondAdLIF_STDP_FIserver(${n})" | matlab

echo "done"
