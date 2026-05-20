#!/bin/bash

# Run from BIDS code/preprocessing directory: sbatch slurm_fmriprep.sh

# Name of job?
#SBATCH --job-name=mindeye_fmriprep

# Set partition
#SBATCH --partition=all

# How long is job?
#SBATCH -t 18:00:00

# Set array to be your session number
#SBATCH --array=07

# Where to output log files? The log file will be in the format of the job ID_array number
# make sure this logs directory exists!! otherwise the script won't run
#SBATCH --output='../../data/bids/derivatives/fmriprep/logs/fmriprep-%A_%a.log'

# How much memory to allocate (in MB)?
#SBATCH --cpus-per-task=8 --mem-per-cpu=20000

# Update with your email 
#SBATCH --mail-user=rsiyer@princeton.edu
#SBATCH --mail-type=BEGIN,END,FAIL

echo "Double-check the bids-filter-file before proceeding!"

# Remove modules because Singularity shouldn't need them
echo "Purging modules"
module purge

# Print job submission info
echo "Slurm job ID: " $SLURM_JOB_ID
date

# Set subject ID based on array index
# printf -v subj "%03d" $SLURM_ARRAY_TASK_ID

# Set session ID based on array index. -v tells printf to save the output to a variable called "session"
printf -v session "%02d" $SLURM_ARRAY_TASK_ID

# Run fMRIPrep script with participant argument
echo "Running fMRIPrep on sub-005"

./run_fmriprep.sh 005

echo "Finished running fMRIPrep on sub-005"
date

# Deface post-fmriprep T1w template image for data sharing
echo "Defacing preprocessed T1w for sub-$subj"

./deface_template.sh 005 $session

echo "Finished defacing T1w"
