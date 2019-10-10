#!/bin/bash
#SBATCH --nodes=1
#SBATCH --array=1-3
#SBATCH --cpus-per-task=20
#SBATCH --time=100:00:00
#SBATCH --mem=20GB
#SBATCH --job-name=iSTDP_Testing
#SBATCH --mail-type=END
#SBATCH --mail-user=jmg1030@nyu.edu
#SBATCH --output=iSTDP_Testing_%j.out

n=${SLURM_ARRAY_TASK_ID}

module purge
module load matlab/2018a

echo "CondAdLIF_iSTDP_Testing(${n})" | matlab

echo "done"
