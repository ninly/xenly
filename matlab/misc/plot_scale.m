function plot_scale(deg,lab)
% plot scale degrees on a line
% INPUTS
%   deg : vector of scale degrees as cents values, where last element is
%         the scale period
%   lab : cell array of strings corresponding to input degrees in deg

if isrow(deg)
    deg = deg.';
end

if deg(1) ~= 0 % input 0th degree not necessary, but will be plotted
    deg = [0;deg];
end

% need to assume well-formed input (last element is scale period)
% if deg(end) ~= 1200
%     deg = [deg;1200];
% end

if ~exist('lab','var')
    lab = sprintfc('%.2f',deg);
end

fig = figure();
ax = axes(fig);

% deg = [1 8/7 7/6 5/4 4/3 3/2 2].';\
% deg = 1200*log2(deg);

% plot(log2(deg),0,'x');
ax.XLim = [0 deg(end)];
ax.YLim = [0 eps];
ax.DataAspectRatio = [1 1 1];

% ax.XTick = 1200*log2(deg);
ax.XTick = deg;
ax.XTickLabel = lab;
ax.XTickLabelRotation = 45;