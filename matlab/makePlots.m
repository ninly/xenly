function makePlots(sourceEdo, extent)

if ~exist('sourceEdo', 'var')
    error('need sourceEdo defined')
end

if ~exist('extent', 'var')
    extent = 2;
end

range = [-extent:1:extent]';
targs = sourceEdo + range;
targs(targs == sourceEdo) = [];

for idx = 1:length(targs)
    close all;
    bridgeHackError(sourceEdo, targs(idx), 1);
end
