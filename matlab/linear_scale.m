function [deg,I,is_MOS,step_size] = linear_scale(N, gen, per)
% LINEARSCALE build a rank-2 linear scale and represent its degree
%   values (and some associated data)
%
% Inputs
%   N : number of desired scale degrees
%   gen : generator value in cents (default: JI fifth)
%   per : scale period in cents (default: 1200)
%
% Outputs
%   deg : column vector of degree values in cents (skipping 1/1,
%         and including period)
%   I : generator order corresponding to each degree
%   mos : boolean indicating whether scale is a moment of symmetry
%   step : step size in cents for each degree
%
% TODO
%   This does not allow for octave-repeating scales with a period less than 2/1.
%   Is that a real thing?

if ~exist('per','var')
    per = 1200;
end

if ~exist('gen','var')
    gen = cents(3/2);
end

deg = nan(N-1,1);
next_deg = 0;
for idx = 1:N-1
    next_deg = next_deg + gen;
    while next_deg > per
        next_deg = next_deg - per;
    end

    if ismember(next_deg,deg) || next_deg == per
        warning(['This generator cannot produce more than ' num2str(idx) ' scale degrees.']);
        deg(isnan(deg)) = []; % clear allocated spaces that won't be filled
        break
    else
        deg(idx) = next_deg;
    end
end

if ~ismember(per,deg)
    deg = [deg;per];
end

[deg,I] = sort(deg);
I = [I(1:end-1);0];

% determine whether scale is a moment of symmetry
step_size = round(diff([0;deg]), 10); % round to 10 decimal places
is_MOS = false;
if length(unique(step_size)) == 2
    is_MOS = true;
end
