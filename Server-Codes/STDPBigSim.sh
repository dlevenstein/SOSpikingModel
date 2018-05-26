#!/bin/bash
#SBATCH --nodes=1
#SBATCH --array=1
#SBATCH --cpus-per-task=10
#SBATCH --time=48:00:00
#SBATCH --mem=100GB
#SBATCH --job-name=BigSim
#SBATCH --mail-type=END
#SBATCH --mail-user=jmg1030@nyu.edu
#SBATCH --output=BigSim_%j.out

module purge
module load matlab/2018a

echo "CondAdLIF_STDPWeightServer(3)" | matlab

echo "done"
