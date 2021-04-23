function [fret_position] = calc_fret_positions(equal_div, n_frets, scale_len)
% CALCFRETPOSITIONS calculate fret positions (as distances from bridge) for a
% given equal division of the octave.
% 
% Inputs:
%   equal_div : the ED2 to calculate fret positions for
%   nFrets   : the number of frets to generate positions for
%   scale_len : the guitar scale length, nut to bridge (default output is 
%              relative to a 648-mm scale length)

if nargin > 4 || nargin < 1
    error('calcFretPositions() : Invalid input')
end
if ~exist('doPlot','var')
    do_plot = 0;
end
if ~exist('n_frets','var')
    n_frets = equal_div; % default to one octave of frets
end
if ~exist('scale_len','var')
    scale_len = 648; % long scale standard is 648 mm, or 25.5 in
end

len_ratio = 2.^((1:n_frets)' ./ equal_div); % fret position as fraction of scale length
fret_position = scale_len ./ len_ratio; % fret position in units of given scale length

% if(do_plot)
%     x = [0:0.001:scale_len];
%     figure(); ax = axes();
%     y1 = get(gca,'ylim')
%     hold(ax,'on');
%     for idx = length(1:nFrets)
%         plot(ax, [posVec(idx) posVec(idx)], y1)
%     end
% end
