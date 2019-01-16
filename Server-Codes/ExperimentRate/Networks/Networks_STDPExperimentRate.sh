#!/bin/bash
#SBATCH --nodes=1
#SBATCH --array=1-4
#SBATCH --cpus-per-task=8
#SBATCH --time=100:00:00
#SBATCH --mem=62GB
#SBATCH --job-name=ExperimentRateNetwork
#SBATCH --mail-type=END
#SBATCH --mail-user=jmg1030@nyu.edu
#SBATCH --output=ExperimentRateNetwork_%j.out

n=${SLURM_ARRAY_TASK_ID}

module purge
module load matlab/2018a

echo "CondAdLIF_STDP_Mean_Testing_ExperimentRate(${n})" | matlab
echo "CondAdLIF_STDP_Scrambled_Testing_ExperimentRate(${n})" | matlab

echo "done"
