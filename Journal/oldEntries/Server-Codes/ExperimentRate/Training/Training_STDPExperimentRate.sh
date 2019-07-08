#!/bin/bash
#SBATCH --nodes=1
#SBATCH --array=1-3
#SBATCH --cpus-per-task=4
#SBATCH --time=100:00:00
#SBATCH --mem=62GB
#SBATCH --job-name=ExperimentRate
#SBATCH --mail-type=END
#SBATCH --mail-user=jmg1030@nyu.edu
#SBATCH --output=ExperimentRate_%j.out

n=${SLURM_ARRAY_TASK_ID}

module purge
module load matlab/2018a

echo "CondAdLIF_Training_STDPExperimentWeight(${n})" | matlab

echo "done"
