% Look at error in Ivor Darreg's pseudo-24edo guitar concept
ccc;

% nFrets = 10; % set number of frets desired (minimum 1 octave)

origEdo = 12;
srcEdo = 12; % we start with a regular 12-edo guitar
trgEdo = 26; % the ed2 we're moving the bridge to approximate
nFrets = 14;

sourceScaleLen = 648;  % standard long-scale length is 648 mm

% if ((nFrets < trgEdo) && (trgEdo < srcEdo)) || ((nFrets > trgEdo) && (trgEdo > srcEdo))
%     nFrets = trgEdo;
% end

% fret positions of 12edo guitar (linear distance from bridge)
fretPos_Orig = calc_fret_positions(origEdo, nFrets, sourceScaleLen);

% Darreg adds frets exactly halfway between standard 12edo frets, so we 
% calculate that halfway distance behind each fret
fretPos_DarregNewFrets = diff([sourceScaleLen;fretPos_Orig])./2;

% populate the Darreg pseudo-24edo fret position vector
fretPos_Darreg = nan(2*nFrets,1);
fretPos_Darreg(2:2:end) = fretPos_Orig;
fretPos_Darreg(1:2:end) = fretPos_Orig - fretPos_DarregNewFrets;

% calculate actual 24edo fret positions
fretPos_24edo = calc_fret_positions(24, 24, sourceScaleLen);

%%
% Let's see how far off we are from true 24 edo
% linear distance error between correct fret position and hack
% errLinear = fretPos_24edo - fretPos_Darreg;
% centsErr = cents(fretPos_Darreg./fretPos_24edo);

%%
% Now we move the bridge to a distance from the nut that is
% twice that of the target pseudo-EDth octave fret
targetDistanceFromNut = sourceScaleLen - fretPos_Darreg(trgEdo);
targetScaleLen = 2*targetDistanceFromNut;   % distance from nut to new position of bridge

scaleLenDelta = sourceScaleLen - targetScaleLen;            % how far it moved
% fretPosDelta = fretPos_Darreg - fretPos_24edo;

% frets distance from bridge if the guitar were designed for the target ed2
fretPosTarget = calc_fret_positions(trgEdo, 2*nFrets, targetScaleLen);
% and where they actually are (relative to bridge)
fretPosHack = fretPos_Darreg - scaleLenDelta;

% convert to positions relative to nut instead of bridge
% fretPos12_nut = scaleLenSource - fretPosSrc;
% fretPosNew_nut = scaleLenTarget - fretPosTarget;

%%
% error in millimeters between correct fret position and hack
errLinear = fretPosTarget - fretPos_Darreg;
% errLinear_nut = fretPos12_nut-fretPosNew_nut;
centsErr = cents(fretPosHack./fretPosTarget);

%%
figure;
ax = axes();
% yyaxis left;
plot(0:2*nFrets, [0;centsErr],'o:');

title(['Octave at fret ' num2str(trgEdo) ' on Darreg pseudo-' num2str(2*srcEdo) ' guitar']);
xlabel('Fret Number');
ylabel('Error (cents)');
% ylimVal(1) = ceil(max(abs(centsErr)));
% if ylimVal(1) == 0
%     ylimVal(1) = 1;
% end
% ylim([-ylimVal(1) ylimVal(1)]);

% yyaxis right;
% plot(0:nFrets, [0;errLinear],'x:');
% ylabel('Error (millimeters)');
% ylimVal(2) = ceil(max(abs(errLinear)));
% if ylimVal(2) == 0
%     ylimVal(2) = 1;
% end
% ylim([-ylimVal(2) ylimVal(2)]);
% xlim([0 nFrets]);

ax.XMinorTick = 'on';
ax.XMinorGrid = 'on';
ax.YMinorTick = 'on';
ax.YMinorGrid = 'on';

%%
edNewCents = edo(trgEdo);
if length(centsErr) > trgEdo
    edNewCents = [edNewCents;edNewCents(1:length(centsErr)-trgEdo)+1200];
end
    
edHackCents = edNewCents + centsErr;

fn = ['bridgeHack' num2str(srcEdo) 'to' num2str(trgEdo) '_' num2str(nFrets) '.scl'];

descrip = ['Intervals along one string after moving the floating bridge on a ' num2str(srcEdo) '-ED2 guitar to approximate ' num2str(trgEdo) '-ED2.'];

sclFileCents(edHackCents, fn, descrip);