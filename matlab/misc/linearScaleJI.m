function [deg_cents,I,mos,step] = linearScaleJI(N, gen, per)
%% build a linear scale

% per = 2/1; % period
% gen = 3/2; % generator

% N = 7;
if ~exist('per','var')
    per = 2/1;
end

if ~exist('gen','var')
    per = 3/2;
end

deg_rat = nan(N,1);
for idx = 1:N-1
    deg_rat(idx) = gen^idx;
    while deg_rat(idx) > per
        deg_rat(idx) = deg_rat(idx)/per;
    end
end

deg_rat(N) = 2;

deg_cents = cents(deg_rat);
[deg_cents,I] = sort(deg_cents);
I = [I(1:end-1);0];

% sorted_rat = sort(deg_rat);
% step_ratios = [sorted_rat]./[1;sorted_rat(1:end-1)]; % BROKEN

% determine whether scale is a moment of symmetry
step = round(diff([0;deg_cents]),10);
mos = false;
if length(unique(step)) == 2
    mos = true;
end