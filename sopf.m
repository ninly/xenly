% sopf rats

function [out, n, d] = sopf(R, L)
% caluculate sum of prime factors of some rational number
%   out : integer sum of prime factors
%   R : some rational number

if ~exist('L','var')
    L = 1;
end

tol = eps('double');
[n,d] = rat(R,tol);

out = norm(factor(n), L) + norm(factor(d), L);
