#!/bin/bash
#SBATCH --nodes=1
#SBATCH --array=1-2
#SBATCH --cpus-per-task=10
#SBATCH --time=12:00:00
#SBATCH --mem=70GB
#SBATCH --job-name=STDP_Balance
#SBATCH --mail-type=END
#SBATCH --mail-user=jmg1030@nyu.edu
#SBATCH --output=STDP_%j.out

n=${SLURM_ARRAY_TASK_ID}

module purge
module load matlab/2018a

echo "CondAdLIF_STDPBalanceServer(${n})" | matlab

echo "done"
