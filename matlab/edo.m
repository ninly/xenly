function [scale, stepsize] = edo(d, p)
if nargin == 1
    p = 2;
end

degrees = (1:d).';
stepsize = cents(p) / d;
scale = cents(p) .* (degrees/d);