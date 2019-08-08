function [m,p] = monzo(r,limit)
if nargin == 1
    limit = 0; % produce "minimum" monzo (no zero-padding)
end

tol = 1e-12;
[n,d] = rat(r,tol);

f = factor(n);
g = factor(d);
efflimit = max([f g]); % effective prime limit of the given interval ratio
if limit == 0
    p = primes(efflimit);
elseif limit < efflimit
    error(['prime limit must be at least ' num2str(efflimit) ' for this interval']);
else
    p = primes(limit);
end

h = nan(1,length(p));
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