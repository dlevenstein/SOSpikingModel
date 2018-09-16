#!/bin/bash
#SBATCH --nodes=1
#SBATCH --array=1-500
#SBATCH --cpus-per-task=21
#SBATCH --time=100:00:00
#SBATCH --mem=62GB
#SBATCH --job-name=SingleWeight
#SBATCH --mail-type=END
#SBATCH --mail-user=jmg1030@nyu.edu
#SBATCH --output=SingleWeight_%j.out

n=${SLURM_ARRAY_TASK_ID}

module purge
module load matlab/2018a

echo "CondAdLIF_STDP_FI_Function_SingleWeight(${n})" | matlab

echo "done"
