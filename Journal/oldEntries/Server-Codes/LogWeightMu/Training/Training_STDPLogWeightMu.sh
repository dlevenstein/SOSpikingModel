#!/bin/bash
#SBATCH --nodes=1
#SBATCH --array=1-5
#SBATCH --cpus-per-task=4
#SBATCH --time=100:00:00
#SBATCH --mem=62GB
#SBATCH --job-name=LogWeightMu
#SBATCH --mail-type=END
#SBATCH --mail-user=jmg1030@nyu.edu
#SBATCH --output=LogWeightMu_%j.out

n=${SLURM_ARRAY_TASK_ID}

module purge
module load matlab/2018a

echo "CondAdLIF_Training_STDPLogWeightMu(${n})" | matlab

echo "done"
