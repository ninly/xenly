function d = divisors(n)
v = 1:n;
dx = mod(n,v) == 0;

d = v(dx);