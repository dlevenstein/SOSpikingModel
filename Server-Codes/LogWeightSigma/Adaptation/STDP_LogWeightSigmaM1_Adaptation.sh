#!/bin/bash
#SBATCH --nodes=1
#SBATCH --array=1-4
#SBATCH --cpus-per-task=2
#SBATCH --time=100:00:00
#SBATCH --mem=40GB
#SBATCH --job-name=AdaptationLogWeight
#SBATCH --mail-type=END
#SBATCH --mail-user=jmg1030@nyu.edu
#SBATCH --output=AdaptationLogWeight_%j.out
#SBATCH --gres=gpu:k80:1

n=${SLURM_ARRAY_TASK_ID}

module purge
module load matlab/2018a

echo "CondAdLIF_STDP_LogWeightSigmaM1_Adaptation_Noise(${n})" | matlab

echo "done"
