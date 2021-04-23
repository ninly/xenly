function s = ratStr(r)

tol = eps('double');
[n,d] = rat(r,tol);

s = [num2str(n) '/' num2str(d)];