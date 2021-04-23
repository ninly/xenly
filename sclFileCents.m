function sclFileCents(cents, filename, descrip)
% Generate a scala file from a list of cents values
fstLine = ['! ' filename '\n'];
emptyCmt = ['! \n'];

if nargin == 2 || strcmp(descrip,'')
    sndLine = '\n';
else
    sndLine = [descrip '\n'];
end

if cents(1) == 0 % Scala files omit the 1/1
    cents = cents(2:end);
end

thdLine = [' ' num2str(length(cents)) '\n'];

fp = fopen(filename,'w');

fprintf(fp, fstLine);
fprintf(fp, emptyCmt);
fprintf(fp, sndLine);
fprintf(fp, thdLine);
fprintf(fp, emptyCmt);
fprintf(fp, ' %.3f\n', cents); 

fclose(fp);
