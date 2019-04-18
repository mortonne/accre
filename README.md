# accre
Scripts for running MATLAB on the ACCRE cluster at Vanderbilt.

## Overview

Requires the MATLAB Parallel Computing Toolbox to submit jobs. Does not require the MATLAB Parallel Server.

Can use the scripts here to run independent (AKA "embarassingly parallel") jobs on ACCRE compute nodes. Each job can then make use of multiple cores by opening a parallel pool. This requires having a MATLAB session on a login node for running the job submission. After jobs are submitted, MATLAB can be closed.

This is tested on ACCRE, but may work for other clusters using the Slurm scheduler, where MATLAB is installed on both the login nodes and the compute nodes.

## Installation

To install, just get a copy of this project and add it to your MATLAB path.

## Examples

To submit a single job to calculate 2 + 3 on a compute node:
```matlab
job = submit_job(@plus, 1, {2 3}, '-t 00:20:00 --mem=4gb --partition=debug')
 fetchOutputs(job) % 3
```

To test using a parfor loop to use multiple cores in a single job:
```matlab
flags = '-t 00:20:00 --mem=4gb --cpus-per-task=4 --partition=debug';
job = submit_job(@par_job, 1, {4}, flags)
fetchOutputs(job) % time to pause for one second 40 times
```

To run multiple independent jobs:
```matlab
cluster = parallel.cluster.Generic();
cluster.JobStorageLocation = '~/runs';
cluster.IntegrationScriptsLocation = '~/matlab/accre';
cluster.AdditionalProperties.AdditionalSubmitArgs = [' ' flags];
job = createJob(cluster);
submit(job);

```
