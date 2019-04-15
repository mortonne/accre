
% storage location
storageLoc = getenv('MDCE_STORAGE_LOCATION');
c = regexp(storageLoc, 'UNIX', 'split');
ind = strfind(c{2}, '{');
sdir = c{2}(ind(1)+1:end-2);
fprintf('Storage location: %s\n', sdir);

taskLocation = getenv('MDCE_TASK_LOCATION');
outfile = fullfile(sdir, [taskLocation '.out.mat']);

startdatetime = datetime('now', 'TimeZone', 'local');
lastwarn('');
diagnosticwarnings = {};

try
    % load task spec    
    in = load(fullfile(sdir, [taskLocation '.in.mat']));
    argsout = cell(1, in.nargout);
    fprintf('Running %s with arguments:\n', func2str(in.taskfunction));
    celldisp(in.argsin)
    diary(fullfile(sdir, [taskLocation '.diary.txt']));
    [argsout{:}] = in.taskfunction(in.argsin{:});
    diary off
    
    % display output
    disp('Output:')
    celldisp(argsout)

    % write output in standard format
    outfile = fullfile(sdir, [taskLocation '.out.mat']);
    finishdatetime = datetime('now', 'TimeZone', 'local');
    worker = struct();
    
    errorstruct = '';
    erroridentifier = '';
    errormessage = '';
    
    [lastmsg, lastid] = lastwarn;
    warnings = struct('identifier', lastid, 'message', lastmsg, ...
                      'stack', struct);

    save(outfile, 'argsout', 'erroridentifier', ...
         'errormessage', 'errorstruct', 'warnings', 'worker', ...
         'diagnosticwarnings', 'startdatetime', 'finishdatetime');
catch Error
    argsout = {};
    finishdatetime = datetime('now', 'TimeZone', 'local');
    worker = struct();
    
    errorstruct = Error;
    erroridentifier = Error.identifier;
    errormessage = Error.message;
    
    [lastmsg, lastid] = lastwarn;
    warnings = struct('identifier', lastid, 'message', lastmsg);
    
    save(outfile, 'argsout', 'erroridentifier', ...
         'errormessage', 'errorstruct', 'warnings', 'worker', ...
         'diagnosticwarnings', 'startdatetime', 'finishdatetime');
end
