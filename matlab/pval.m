function val = pval(ed, limit, period)
% generate patent val for given equal division, prime limit, and period

% default period is 2 (octave equivalence)
if ~exist('period','var')
    period = 2;
end

val = round(ed * log(primes(limit))/log(period));