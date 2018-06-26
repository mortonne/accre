
startdatetime = datetime('now');

% storage location
storageLoc = getenv('MDCE_STORAGE_LOCATION');
c = regexp(storageLoc, 'UNIX', 'split');
ind = strfind(c{2}, '{');
sdir = c{2}(ind(1)+1:end-2);
fprintf('Storage location: %s\n', sdir);

taskLocation = getenv('MDCE_TASK_LOCATION');
outfile = fullfile(sdir, [taskLocation '.out.mat']);

try
    % load task spec    
    in = load(fullfile(sdir, [taskLocation '.in.mat']));
    argsout = cell(1, in.nargout);
    diary(fullfile(sdir, [taskLocation '.diary.txt']));
    [argsout{:}] = in.taskfunction(in.argsin{:});
    diary off
    
    % display output
    disp('Output:')
    celldisp(argsout)

    % write output in standard format
    outfile = fullfile(sdir, [taskLocation '.out.mat']);
    finishdatetime = datetime('now');
    diagnosticwarnings = {};
    erroridentifier = '';
    errormessage = '';
    errorstruct = '';
    worker = struct();
    
    save(outfile, 'argsout', 'erroridentifier', ...
         'errormessage', 'errorstruct', 'worker', ...
         'diagnosticwarnings', 'startdatetime', 'finishdatetime');
catch Error
    argsout = {};
    finishdatetime = datetime('now');
    diagnosticwarnings = {};
    erroridentifier = Error.identifier;
    errormessage = Error.message;
    errorstruct = Error.stack;
    worker = struct();
    
    save(outfile, 'argsout', 'erroridentifier', ...
         'errormessage', 'errorstruct', 'worker', ...
         'diagnosticwarnings', 'startdatetime', 'finishdatetime', 'Error');
end
