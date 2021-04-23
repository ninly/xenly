% Figure out how far out my 10-edo/11-edo guitar hack was
ccc;

% nFrets = 10; % set number of frets desired (minimum 1 octave)

srcEd2 = 19; % the ed2 the frets were designed for
trgEd2 = 17; % the ed2 we're "hacking" to achieve
nFrets = max([srcEd2 trgEd2]);

scaleLenSource = 648;  % standard long-scale length is 648 mm

% if ((nFrets < trgEd2) && (trgEd2 < srcEd2)) || ((nFrets > trgEd2) && (trgEd2 > srcEd2))
%     nFrets = trgEd2;
% end

fretPosSrc = calc_fret_positions(srcEd2, nFrets, scaleLenSource);

%%
% Now we move the bridge to a distance twice that of the target EDth fret
% from the nut
scaleLenTarget = 2*(scaleLenSource - fretPosSrc(trgEd2));   % distance from nut to new position of bridge
scaleLenDelta = scaleLenSource - scaleLenTarget;            % how far it moved

% frets distance from bridge if the guitar were designed for the target ed2
fretPosTarget = calc_fret_positions(trgEd2, nFrets, scaleLenTarget);
% and where they actually are
fretPosHack = fretPosSrc - scaleLenDelta;

% convert to positions relative to nut instead of bridge
% fretPos12_nut = scaleLenSource - fretPosSrc;
% fretPosNew_nut = scaleLenTarget - fretPosTarget;

%%
% error in millimeters between correct fret position and hack
errLinear = fretPosTarget - fretPosHack;
% errLinear_nut = fretPos12_nut-fretPosNew_nut;
centsErr = cents(fretPosHack./fretPosTarget);

%%
figure;
ax = axes();
% yyaxis left;
plot(0:nFrets, [0;centsErr],'o:');

title(['Octave at ' num2str(trgEd2) '\\' num2str(srcEd2)]);
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
edNewCents = edo(trgEd2);
if length(centsErr) > trgEd2
    edNewCents = [edNewCents;edNewCents(1:length(centsErr)-trgEd2)+1200];
end
    
edHackCents = edNewCents + centsErr;

fn = ['bridgeHack' num2str(srcEd2) 'to' num2str(trgEd2) '_' num2str(nFrets) '.scl'];

descrip = ['Intervals along one string after moving the floating bridge on a ' num2str(srcEd2) '-ED2 guitar to approximate ' num2str(trgEd2) '-ED2.'];

sclFileCents(edHackCents, fn, descrip);