function [m,p] = monzo(r, limit)
% MONZO convert a rational number to monzo form (vector of powers of
% its prime factors.

if ~exist('limit', 'var')
    limit = 0; % produce "minimum" monzo (no zero-padding)
end

tol = eps('double'); % TODO: test input against tolerance
[n,d] = rat(r,tol);

f = factor(n);
g = factor(d);
efflimit = max([f g]); % effective prime limit of the given interval ratio
if limit == 0
    p = primes(efflimit);
elseif limit < efflimit
    error(['monzo() : prime limit must be at least ' num2str(efflimit) ' for the given interval']);
else
    p = primes(limit);
end

h = nan(length(p),1);
j = h;
m = h;

idx = 1;
% while (max([f(end) g(end)]) ~= p(idx))
while (max(p) ~= p(idx))
    h(idx) =  nnz(f == p(idx));
    j(idx) = -nnz(g == p(idx));
    idx = idx + 1;
end
h(idx) =  nnz(f == p(idx));
j(idx) = -nnz(g == p(idx));
m = h + j;

%% unit test
% Monzos list powers of corresponding primes, so those primes taken to
% those powers should result in the input value.
% if prod(p.^M) ~= r
%     errStr = ['Houston... ' num2str(prod(p.^M)) ' ~= ' num2str(r)];
%     error(errStr);
% end
