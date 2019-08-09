function [octaves, cents] = pote(M)
% POTE find pure-octave tenney-euclidean (POTE) generators for a given temperament map

% get primes up to p-limit
[~,N] = size(M);
pp = primes(100);
pp = pp(1:N);
limit = pp(end);

% form diagonal matrix of inverse-prime weights
PD = diag(1./log2(pp));

V = M*PD;
P = V.' * inv(V*V.'); % pseudoinverse?

T = ones(1,N)*P;
octaves = T./T(1);
cents = 1200*octaves;