% Creating a simple binary file
fid = fopen("adat.bin",'w');

% write some content (integers - 1 byte long! each)
fwrite(fid, [1:9]);

% close file after usage
fclose(fid);
