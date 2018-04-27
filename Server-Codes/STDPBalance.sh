#!/bin/bash
#SBATCH --nodes=1
#SBATCH --array=1-5
#SBATCH --cpus-per-task=20
#SBATCH --time=24:00:00
#SBATCH --mem=225GB
#SBATCH --job-name=STDP_Balance
#SBATCH --mail-type=END
#SBATCH --mail-user=jmg1030@nyu.edu
#SBATCH --output=STDP_%j.out

n=${SLURM_ARRAY_TASK_ID}

module purge
module load matlab/2018a

echo "CondAdLIF_STDPBalanceServer(${n})" | matlab

echo "done"
