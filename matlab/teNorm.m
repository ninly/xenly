function [te] = teNorm(m)
% TENORM calculate the Tenney-Euclidean norm of a given monzo
%
% inputs:
%   M : A just interval represented as a vector of its prime factors (a
%   monzo). e.g. 4/3 in monzo form = | 2 -1 >.

if isrow(m)
    m = m';
end

N = length(m);

% get primes up to p-limit
p = primes(100);
p = p(1:N); 

% leaving open to possible future non-octave equiv. or TOP calculations
base = 2;
W = diag(log(base)./log(p)); % vector of inverse of base-n log
M_weighted = W*m; % log-weighted monzo

te = norm(M_weighted)/sqrt(N);