function cluster = getCluster(varargin)
%GETCLUSTER   Get a standard cluster object.
%
%  cluster = getCluster(...)
%
%  OPTIONS:
%  storage_dir - char - '~/runs'
%      Path to directory to store job data.

def.storage_dir = '~/runs';
opt = propval(varargin, def);

cluster = parallel.cluster.Generic();
cluster.JobStorageLocation = opt.storage_dir;
cluster.IntegrationScriptsLocation = fileparts(mfilename('fullpath'));
