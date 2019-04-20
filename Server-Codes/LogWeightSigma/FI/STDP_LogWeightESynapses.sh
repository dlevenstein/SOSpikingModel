#!/bin/bash
#SBATCH --job-name=LogWeightESynapses
#SBATCH --nodes=1
#SBATCH --array=1-4
#SBATCH --cpus-per-task=10
#SBATCH --time=100:00:00
#SBATCH --mem=20GB
#SBATCH --job-name=LogWeightESynapses
#SBATCH --output=LogWeightESynapses_%j.out
#SBATCH --mail-type=END
#SBATCH --mail-user=jmg1030@nyu.edu

n=${SLURM_ARRAY_TASK_ID}

module purge
module load matlab/2018a

echo "parpool('local',10);CondAdLIF_STDP_FI_Function_LogWeightESynapses(${n})" | matlab

echo "done"
