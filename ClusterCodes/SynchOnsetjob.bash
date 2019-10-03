#!/bin/bash
#SBATCH -p cpu_short
#SBATCH --nodes=1
#SBATCH --tasks-per-node=45
#SBATCH --time=12:00:00
#SBATCH --mem-per-cpu=6G
echo $1
module load matlab/R2018a

export SCRATCH=/gpfs/scratch/dl2820
mkdir -p $SCRATCH/$SLURM_JOB_ID

#matlab -nodisplay -nodesktop -singleCompThread -r "cd('/gpfs/data/buzsakilab/DL/NeuronalHeterogeneity/ClusterCodes');addPaths;bz_RunAnalysis('OptimizeSleepScoreParms','$1','basePath',true);exit;"
matlab -nodisplay -nodesktop -singleCompThread -r "cd('/gpfs/data/buzsakilab/DL/SOSpikingModel/ClusterCodes');addPaths;CondAdLIF_iSTDP_PSpikeOnset('/gpfs/data/buzsakilab/DL/SOSpikingModel',0);exit;"

rm -rf $SCRATCH/$SLURM_JOB_ID