function duration = par_job(n_workers)
%PAR_JOB   Run a test job with a parpool.
%
%  duration = par_job(n_workers)

% open up a job-specific parpool
[pool, cluster] = job_parpool(n_workers);

% display pool and cluster information for debugging purposes
get(cluster)
disp(pool)
get(cluster.Jobs)
get(cluster.Jobs.Tasks(1))
get(cluster.Jobs.Tasks(1).Worker)

% run a simple parfor loop. The corresponding for loop would take
% about [n_workers * 10] s
tic
parfor i = 1:(n_workers * 10)
    pause(1);
end
duration = toc;
