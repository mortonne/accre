# accre
Scripts for running MATLAB on the ACCRE cluster at Vanderbilt.

Requires the MATLAB Parallel Computing Toolbox to submit jobs. Does not require the MATLAB Parallel Server.

Can use the scripts here to run independent (AKA "embarassingly parallel") jobs on ACCRE compute nodes. Each job can then make use of multiple cores by opening a parallel pool. This requires having a MATLAB session on a login node for running the job submission. After jobs are submitted, MATLAB can be closed.

This is tested on ACCRE, but may work for other clusters using the Slurm scheduler, where MATLAB is installed on both the login nodes and the compute nodes.
