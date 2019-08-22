function td = harmonic_distance(r)
%% harmonic distance

tol = eps('double'); % TODO: test input against tolerance
[n,d] = rat(r,tol);

td = log2(n*d);