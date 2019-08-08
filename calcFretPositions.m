function [fretPositionVec] = calcFretPositions(equalDiv, nFrets, scaleLen)
% CALCFRETPOSITIONS calculate fret positions (as distances from bridge) for a
% given equal division of the octave.
% 
% Inputs:
%   equalDiv : the ED2 to calculate fret positions for
%   nFrets   : the number of frets to generate positions for
%   scaleLen : the guitar scale length, nut to bridge (default output is 
%              relative to a 648-mm scale length)

if nargin > 4 || nargin < 1
    error('calcFretPositions() : Invalid input')
end
if ~exist('doPlot','var')
    doPlot = 0;
end
if ~exist('nFrets','var')
    nFrets = equalDiv; % default to one octave of frets
end
if ~exist('scaleLen','var')
    scaleLen = 648; % long scale standard is 648 mm, or 25.5 in
end

ivalRatioVec = 2.^((1:nFrets)'./equalDiv);
fretPositionVec = scaleLen ./ ivalRatioVec;

% if(doPlot)
%     x = [0:0.001:scaleLen];
%     figure(); ax = axes();
%     y1 = get(gca,'ylim')
%     hold(ax,'on');
%     for idx = length(1:nFrets)
%         plot(ax, [posVec(idx) posVec(idx)], y1)
%     end
% end
