function c = monzo2cents(m, basis)
% MONZO2CENTS convert interval monzo to cents value

if isrow(m)
    m = m.';
end

if ~exist('subgroup','var')
    basis = primes(100);
    basis = basis(1:length(m));
end

c = cents(basis)*m;
