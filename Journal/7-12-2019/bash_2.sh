#!/bin/bash
#SBATCH --nodes=1
#SBATCH --array=1
#SBATCH --cpus-per-task=20
#SBATCH --time=100:00:00
#SBATCH --mem=62GB
#SBATCH --job-name=iSTDPAdaptationTest
#SBATCH --mail-type=END
#SBATCH --mail-user=jmg1030@nyu.edu
#SBATCH --output=iSTDPAdaptationTest_%j.out

module purge
module load matlab/2018a

echo "CondAdLIF_iSTDP_StartingAdaptationTest()" | matlab

echo "done"
