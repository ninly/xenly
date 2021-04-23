n = 100;
ss = nan(n,1);
for idx = 1:n
    ss(idx) = sum(factor(idx));
end
figure;stem(ss);