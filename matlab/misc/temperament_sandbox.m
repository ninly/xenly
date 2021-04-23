%% temperament sandbox

limit = 5;

p = cents(primes(limit)).';

meantone = [1 1 0;0 1 4];

%%

pgen = meantone'\p;  % ideal generators

%%
pgen = [1200; 700]; % generators for 12-equal

%%
adjcomma = cents(81/80)/11;
pgen = [1200; cents(3/2)-adjcomma]; 

%% fifth-comma meantone
adjcomma = cents(81/80)/5;

%% quarter-comma meantone
pgen = [1200; 696.578]; % quarter-comma meantone
adjcomma = cents(81/80)/4;

%% 2/7-comma meantone
adjcomma = cents(81/80)*2/7;

%% third-comma meantone
adjcomma = cents(81/80)/3;
pgen = [1200; cents(3/2)-adjcomma]; % third-comma meantone

%%
mtmap = meantone' * pgen

err = mtmap - p

%%

syntonic = monzo(81/80);
