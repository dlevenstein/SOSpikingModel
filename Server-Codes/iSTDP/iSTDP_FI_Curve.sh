#!/bin/bash
#SBATCH --job-name=iSTDP_FI_Curve
#SBATCH --nodes=1
#SBATCH --array=1-4
#SBATCH --cpus-per-task=21
#SBATCH --time=100:00:00
#SBATCH --mem=20GB
#SBATCH --job-name=iSTDP_FI_Curve
#SBATCH --output=iSTDP_FI_Curve_%j.out
#SBATCH --mail-type=END
#SBATCH --mail-user=jmg1030@nyu.edu

n=${SLURM_ARRAY_TASK_ID}

module purge
module load matlab/2018a

if [ "$SLURM_JOBTMP" == "" ]; then
    export SLURM_JOBTMP=/state/partition1/$USER/$$
    mkdir -p $SLURM_JOBTMP
fi

export MATLAB_PREFDIR=$(mktemp -d $SLURM_JOBTMP/matlab-XXXX)

echo
echo "Hostname: $(hostname)"
echo

cat<<EOF | srun matlab -nodisplay
parpool('local', $SLURM_CPUS_PER_TASK)
CondAdLIF_STDP_FI_Function_iSTDP(${n})
exit
EOF

rm -rf $SLURM_JOBTMP/*
