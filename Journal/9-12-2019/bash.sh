#!/bin/bash
#SBATCH --nodes=1
#SBATCH --array=1-2
#SBATCH --cpus-per-task=20
#SBATCH --time=100:00:00
#SBATCH --mem=62GB
#SBATCH --job-name=iSTDPTrainingLongClusters
#SBATCH --mail-type=END
#SBATCH --mail-user=jmg1030@nyu.edu
#SBATCH --output=iSTDPTrainingLongClusters_%j.out

n=${SLURM_ARRAY_TASK_ID}

module purge
module load matlab/2018a

echo "CondAdLIF_iSTDP_Training_Long(${n})" | matlab

echo "done"
