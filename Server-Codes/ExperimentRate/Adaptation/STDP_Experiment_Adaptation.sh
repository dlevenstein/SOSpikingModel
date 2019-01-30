#!/bin/bash
#SBATCH --nodes=1
#SBATCH --array=1-210
#SBATCH --cpus-per-task=4
#SBATCH --time=100:00:00
#SBATCH --mem=12GB
#SBATCH --job-name=Adaptation
#SBATCH --mail-type=END
#SBATCH --mail-user=jmg1030@nyu.edu
#SBATCH --output=Adaptation_%j.out

n=${SLURM_ARRAY_TASK_ID}

module purge
module load matlab/2018a

echo "CondAdLIF_STDP_ExperimentRate_Adaptation(${n})" | matlab

echo "done"
