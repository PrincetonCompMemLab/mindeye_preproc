#!/bin/bash

# Run from BIDS code/preprocessing directory: sbatch slurm_mriqc.sh

# Name of job?
#SBATCH --job-name=mindeye_mriqc

# Where to output log files?
# make sure this logs directory exists!! otherwise the script won't run
#SBATCH --output='../../data/bids/derivatives/mriqc/logs/mriqc-%A_%a.log'

# Set partition
#SBATCH --partition=all

# How long is job?
#SBATCH -t 4:00:00

# How much memory to allocate (in MB)?
#SBATCH --cpus-per-task=8 --mem-per-cpu=14000

# Update with your email 
#SBATCH --mail-user=rsiyer@princeton.edu
#SBATCH --mail-type=BEGIN,END,FAIL

# Remove modules because Singularity shouldn't need them
echo "Purging modules"
module purge

# Print job submission info
echo "Slurm job ID: " $SLURM_JOB_ID
date

# PARTICIPANT LEVEL
echo "Running MRIQC on sub-005"

./run_mriqc.sh 005

echo "Finished running MRIQC on sub-005"
date

# GROUP LEVEL
echo "Running MRIQC on group"

./run_mriqc_group.sh

echo "Finished running MRIQC on group"
date