function job = submit_job(f, n_out, f_inputs, flags, varargin)
%SUBMIT_JOB   Submit a job with one task on ACCRE.
%
%  job = submit_job(f, n_out, f_inputs, flags, ...)
%
%  INPUTS:
%  f - function handle
%      Function to run.
%
%  n_out - int
%      Number of outputs to capture from f.
%
%  f_inputs - cell array
%      Input arguments for f.
%
%  flags - char
%      Flags for sbatch.
%
%  OUTPUTS:
%  job - job object
%      Job object created to track running of the batch job.
%
%  OPTIONS:
%  storage_dir - char
%      Path to directory to store job data in.
%
%  EXAMPLES:
%  # submit a job to calculate 2 + 3
%  job = submit_job(@plus, 1, {2 3}, '-t 00:20:00 --mem=4gb --partition=debug')
%  fetchOutputs(job) % 3
%
%  # submit a job to test parallel execution over 4 workers
%  flags = '-t 00:20:00 --mem=4gb --cpus-per-task=4 --partition=debug';
%  job = submit_job(@par_job, 1, {4}, flags)
%  fetchOutputs(job) % time to pause for one second 40 times

% options
def.storage_dir = '~/runs';
opt = propval(varargin, def);

% set up a cluster
cluster = parallel.cluster.Generic();
cluster.JobStorageLocation = opt.storage_dir;
cluster.IntegrationScriptsLocation = fileparts(mfilename('fullpath'));
cluster.AdditionalProperties.AdditionalSubmitArgs = [' ' flags];

job = createJob(cluster);
task = createTask(job, f, n_out, f_inputs);

submit(job)
