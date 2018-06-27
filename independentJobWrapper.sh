#!/bin/bash

echo " Starting at: $(date)"
start=$(date +%s)
echo " JOB ID:      $SLURM_JOB_ID"
echo " JOB NAME:    $SLURM_JOB_NAME"
echo " NODES:       $SLURM_NODELIST"
echo " N NODES:     $SLURM_NNODES"
echo " N TASKS:     $SLURM_NTASKS"
echo " CPUS/TASK:   $SLURM_CPUS_PER_TASK"
echo " Running: $TASK_SCRIPT"

matlab -nodisplay -nosplash < "$TASK_SCRIPT"

echo " "
echo " Job complete at $(date)"
echo " "
finish=$(date +%s)
printf " Job duration: %02d:%02d:%02d (%d s)
" $(((finish-start)/3600)) $(((finish-start)%3600/60)) $(((finish-start)%60)) $((finish-start))
