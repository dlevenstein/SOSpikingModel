#!/bin/sh

#  STDP_StartWeight1Sim.sh
#  
#
#  Created by Jonathan Gornet on 6/1/18.
#  

#SBATCH --nodes=1
#SBATCH --array=1-6
#SBATCH --cpus-per-task=10
#SBATCH --time=48:00:00
#SBATCH --mem=100GB
#SBATCH --job-name=StartWeight1Sim
#SBATCH --mail-type=END
#SBATCH --mail-user=jmg1030@nyu.edu
#SBATCH --output=StartWeight1Sim_%j.out

n=${SLURM_ARRAY_TASK_ID}

module purge
module load matlab/2018a

echo "CondAdLIF_STDPLargeSimWeightAnalysis(${n})" | matlab

echo "done"
