% Look at error in Ivor Darreg's pseudo-24edo guitar concept
ccc;

origEdo = 12;
srcEdo = 12; % we start with a regular 12-edo guitar
targetEdo = 26; % the equal division we move the bridge to approximate
nFrets_before = 14;
nFrets = 2*nFrets_before;

scale = 1;  % standard long-scale length is 648 mm

%% fret positions of 12edo guitar (linear distance from bridge)
fretPos_orig = scale - calc_fret_positions(origEdo, nFrets_before, scale);

%% Darreg adds frets exactly halfway between standard 12edo frets, so we 
% calculate that halfway distance behind each fret
fretPos_DarregNewFrets = fretPos_orig - diff([0;fretPos_orig])./2;

% populate the Darreg pseudo-24edo fretboard
fretPos_Darreg = nan(nFrets,1);
fretPos_Darreg(2:2:end) = fretPos_orig;
fretPos_Darreg(1:2:end) = fretPos_DarregNewFrets;
% fretPos_Darreg = [0; fretPos_Darreg]; % add zero fret (nut)

%%
% Check against true 24edo
fretPos_24edo = [scale - calc_fret_positions(24, nFrets, scale)];
centsErr = -cents((1-fretPos_Darreg)./(1-fretPos_24edo));

%%
% frets = fretPos_Darreg;
frets(:,1) = [scale - calc_fret_positions(targetEdo, nFrets, scale)];
%%
newScale = 2 * fretPos_Darreg(targetEdo);
frets(:,2) = fretPos_Darreg./newScale;
% frets(:,3) = frets(:,3)./max(frets(:,3));
%%
frets = scale - frets;
zf = repmat(scale,1,2);
frets = [zf;frets];
centsErr = -cents(frets(:,2)./frets(:,1));
% centsErr(1) = 0;

%%
fig = figure;
ax = axes();

plot(0:nFrets, centsErr, 'ko:');
ax.XLim = [0, nFrets];
ax.YLim = [-20, 20];
ax.XTick = [0:nFrets];
ax.YTick = [-20:5:20];

line([0;ax.XLim(2)],[0;0], 'Color', '#222', 'LineStyle', '--');
line([targetEdo;targetEdo],[ax.YLim(1);ax.YLim(2)], 'Color', '#222', 'LineStyle', '--');

grid on, grid minor
ax.XMinorGrid = 'off';

title(['Octave at fret ' num2str(targetEdo) ' on Darreg pseudo-24edo guitar']);
xlabel('Fret Number');
ylabel('Error (cents)');

%%
fn = ['bridgeHackOutput/forBob/darreg_pseudo24_octaveAt' num2str(targetEdo)];
% save Matlab .fig file
fn_fig = [fn '.fig'];
saveas(fig, fn_fig);
% save a jpg
fn_jpg = [fn '.jpg'];
saveas(fig, fn_jpg);

%%
% edNewCents = edo(targetEdo);
% if length(centsErr) > targetEdo
%     edNewCents = [edNewCents;edNewCents(1:length(centsErr)-targetEdo)+1200];
% end
%     
% edHackCents = edNewCents + centsErr;
% 
% fn = ['bridgeHack' num2str(srcEdo) 'to' num2str(targetEdo) '_' num2str(nFrets_before) '.scl'];
% 
% descrip = ['Intervals along one string after moving the floating bridge on a ' num2str(srcEdo) '-ED2 guitar to approximate ' num2str(targetEdo) '-ED2.'];
% 
% sclFileCents(edHackCents, fn, descrip);