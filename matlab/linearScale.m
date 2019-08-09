function [deg,I,mos,step] = linearScale(N, gen, per)
%% build a linear scale

% per = 2/1; % period
% gen = 3/2; % generator

% N = 7;
if ~exist('per','var')
    per = 1200;
end

if ~exist('gen','var')
    gen = cents(3/2);
end

deg = nan(N-1,1);
nextDeg = 0;
for idx = 1:N-1
    nextDeg = nextDeg+gen;
    while nextDeg > per
        nextDeg = nextDeg-per;
    end
    
    if ismember(nextDeg,deg) || nextDeg == per
        warning(['This generator cannot produce more than ' num2str(idx) ' scale degrees.']);
        deg(isnan(deg)) = []; % clear allocated spaces that won't be filled
        break
    else
        deg(idx) = nextDeg;
    end
end

if ~ismember(per,deg)
    deg = [deg;per];
end

% deg_cents = cents(deg_rat);
[deg,I] = sort(deg);
I = [I(1:end-1);0];

% sorted_rat = sort(deg_rat);
% step_ratios = [sorted_rat]./[1;sorted_rat(1:end-1)]; % BROKEN

% determine whether scale is a moment of symmetry
step = round(diff([0;deg]),10); % round to 10 decimal places
mos = false;
if length(unique(step)) == 2
    mos = true;
end