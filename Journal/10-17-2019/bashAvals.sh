#!/bin/bash
#SBATCH --nodes=1
#SBATCH --array=1-3
#SBATCH --cpus-per-task=20
#SBATCH --time=100:00:00
#SBATCH --mem=100GB
#SBATCH --job-name=iSTDP_Adaptation_CurrentAvals
#SBATCH --mail-type=END
#SBATCH --mail-user=jmg1030@nyu.edu
#SBATCH --output=iSTDP_Adaptation_CurrentAvals_%j.out

n=${SLURM_ARRAY_TASK_ID}

module purge
module load matlab/2018a

echo "CondAdLIF_iSTDP_Adaptation_CurrentAvals(${n})" | matlab

echo "done"

