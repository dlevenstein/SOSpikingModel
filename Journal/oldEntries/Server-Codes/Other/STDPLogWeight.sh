#!/bin/bash
#SBATCH --nodes=1
#SBATCH --array=1-3
#SBATCH --cpus-per-task=4
#SBATCH --time=48:00:00
#SBATCH --mem=150GB
#SBATCH --job-name=LogWeight
#SBATCH --mail-type=END
#SBATCH --mail-user=jmg1030@nyu.edu
#SBATCH --output=LogWeight_%j.out

n=${SLURM_ARRAY_TASK_ID}

module purge
module load matlab/2018a

echo "CondAdLIF_STDPLogWeight(${n})" | matlab

echo "done"
