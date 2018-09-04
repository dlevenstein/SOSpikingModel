#!/bin/bash
#SBATCH --nodes=1
#SBATCH --array=1-4000
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --mem=25GB
#SBATCH --job-name=FI_Function_LogWeight
#SBATCH --mail-type=END
#SBATCH --mail-user=jmg1030@nyu.edu
#SBATCH --output=FI_Function_LogWeight_%j.out

n=${SLURM_ARRAY_TASK_ID}

module purge
module load matlab/2018a

echo "CondAdLIF_STDP_FI_Function(${n},1)" | matlab
echo "CondAdLIF_STDP_FI_Function(${n},2)" | matlab
echo "CondAdLIF_STDP_FI_Function(${n},3)" | matlab
echo "CondAdLIF_STDP_FI_Function(${n},4)" | matlab

echo "done"
