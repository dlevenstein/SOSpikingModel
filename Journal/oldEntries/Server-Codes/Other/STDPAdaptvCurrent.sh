#!/bin/bash
#SBATCH --nodes=1
#SBATCH --array=1-1000
#SBATCH --cpus-per-task=2
#SBATCH --time=12:00:00
#SBATCH --mem=25GB
#SBATCH --job-name=AdaptvCurrent
#SBATCH --mail-type=START,END
#SBATCH --mail-user=jmg1030@nyu.edu
#SBATCH --output=AdaptvCurrent_%j.out

n=${SLURM_ARRAY_TASK_ID}

module purge
module load matlab/2018a

echo "CondAdLIF_STDP_AdaptvCurrent(${n})" | matlab

echo "done"
