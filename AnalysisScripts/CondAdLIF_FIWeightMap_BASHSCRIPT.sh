#!/bin/bash
#SBATCH --nodes=1
#SBATCH --array=1-21
#SBATCH --cpus-per-task=10
#SBATCH --time=24:00:00
#SBATCH --mem=10GB
#SBATCH --job-name=CondAdLIF_FIWeightMap
#SBATCH --mail-type=ALL
#SBATCH --mail-user=jmg1030@nyu.edu
#SBATCH --output=CondAdLIF_FIWeightMap%j.out

i=${SLURM_ARRAY_TASK_ID}

module purge
module load matlab/2017a

echo "CondAdLIF_FIWeightMap($i); exit;" | matlab -nodisplay

echo "Done"
