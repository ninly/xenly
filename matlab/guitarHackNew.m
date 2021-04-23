%%
ccc;

numFrets = 15;
frets = 1 - calc_fret_positions(12, numFrets, 1);
frets(:,2) = 1 - calc_fret_positions(13, numFrets, 1);

% scales = [ones(1,2);frets];

%%
% stretch = frets(13,1)/frets(12,1);
% frets(:,3) = frets(:,1) .* stretch

%%
targEdo = 13;
newBridgePos = 2 * frets(targEdo,1);
frets(:,3) = frets(:,1)./newBridgePos;
frets = [ones(1,3); 1-frets];
centsErr = cents(frets(:,3)./frets(:,2));

%%
fig(1) = figure;
ax(1) = axes;

plot(ax(1), [0:numFrets], centsErr, 'o:')
ax.XLim = [0, numFrets];
ax.YLim = [-20, 20];
ax.XTick = [0:numFrets];
ax.YTick = [-20:5:20];


line([0;ax.XLim(2)],[0;0], 'Color', '#222', 'LineStyle', '--');
line([targEdo;targEdo],[ax.YLim(1);ax.YLim(2)], 'Color', '#222', 'LineStyle', '--');
