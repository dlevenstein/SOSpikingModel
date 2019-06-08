#!/bin/bash
#SBATCH --nodes=1
#SBATCH --array=1-2
#SBATCH --cpus-per-task=2
#SBATCH --time=100:00:00
#SBATCH --mem=62GB
#SBATCH --job-name=iSTDPSpikes
#SBATCH --mail-type=END
#SBATCH --mail-user=jmg1030@nyu.edu
#SBATCH --output=iSTDPSpikes_%j.out
#SBATCH --gres=gpu:2

n=${SLURM_ARRAY_TASK_ID}

module purge
module load matlab/2018a

echo "CondAdLIF_iSTDP_Spikes(${n})" | matlab

echo "done"
