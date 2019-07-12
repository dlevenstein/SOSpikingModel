#!/bin/bash
#SBATCH --nodes=1
#SBATCH --array=1
#SBATCH --cpus-per-task=4
#SBATCH --time=100:00:00
#SBATCH --mem=62GB
#SBATCH --job-name=iSTDPInitialValues
#SBATCH --mail-type=END
#SBATCH --mail-user=jmg1030@nyu.edu
#SBATCH --output=iSTDPInitialValues_%j.out
#SBATCH --gres=gpu:1

module purge
module load matlab/2018a

echo "CondAdLIF_iSTDP_InitialValues()" | matlab

echo "done"
