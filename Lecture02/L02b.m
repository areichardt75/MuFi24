% Create a more sophisticated 
filename = 'adatok.bin';
fid = fopen(filename,'w');

fwrite(fid, 100*rand(20,1), 'integer*4');

fclose(fid);

%% Which type is used for numbers
% Reread the file

% open file
fin = fopen(filename);

% read entire file into one single variable
A = fread(fin);

% close after usage
fclose(fin);

%% Read file as 2 byte integers

fin  = fopen(filename);

B = fread(fin,'integer*2');

fclose(fin);

%%