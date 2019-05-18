#!/bin/bash
#SBATCH --nodes=1
#SBATCH --array=1
#SBATCH --cpus-per-task=1
#SBATCH --time=100:00:00
#SBATCH --mem=62GB
#SBATCH --job-name=iSTDPTraining
#SBATCH --mail-type=END
#SBATCH --mail-user=jmg1030@nyu.edu
#SBATCH --output=iSTDPTraining_%j.out
#SBATCH --gres=gpu:1

n=${SLURM_ARRAY_TASK_ID}

module purge
module load matlab/2018a

echo "CondAdLIF_iSTDP_Training_Clusters(${n})" | matlab

echo "done"
