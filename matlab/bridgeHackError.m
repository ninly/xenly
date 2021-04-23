function centsErr = bridgeHackError(sourceEdo, targetEdo)

numFrets = ceil(targetEdo * 9/8);
scaleLen = 1;
frets = scaleLen - calc_fret_positions(sourceEdo, numFrets, scaleLen);
frets(:,2) = scaleLen - calc_fret_positions(targetEdo, numFrets, scaleLen);

%%
newBridgePos = 2 * frets(targetEdo,1);
frets(:,3) = frets(:,1)./newBridgePos;
% add zero-fret
frets = [ones(1,3); 1-frets];
centsErr = cents(frets(:,3)./frets(:,2));

%%
fig(1) = figure;
ax(1) = axes;

plot(ax(1), [0:numFrets], centsErr, 'ko:')
ax.XLim = [0, numFrets];
ax.YLim = [-20, 20];
ax.XTick = [0:numFrets];
ax.YTick = [-20:5:20];

line([0;ax.XLim(2)],[0;0], 'Color', '#222', 'LineStyle', '--');
line([targetEdo;targetEdo],[ax.YLim(1);ax.YLim(2)], 'Color', '#222', 'LineStyle', '--');

grid on, grid minor

title(['Octave at ' num2str(targetEdo) '\\' num2str(sourceEdo)])