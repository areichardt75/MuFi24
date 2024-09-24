% Use file randomadat.bin file
% Read file as a uint16 numbers 
% 
% Random numbers were generated and saved to this file as float64 numbers. 

filename = 'randomadat.bin';

fin = fopen(filename);
temp_data = fread(fin,'uint8');

disp(['Length : ' num2str(length(temp_data)) ' bytes.']); 

frewind(fin);

data = fread(fin,Inf,"uint16");

fclose(fin);

%% Format data
% Reshape data into x-y arrangement

reshp_data = transpose(reshape(temp_data,[],2));
X = reshp_data(1,:);
Y = reshp_data(2,:);

[Xsorted,I] = sort(X);
Ysorted = Y(I);

figure; 
  plot(Xsorted,Ysorted,'r-'),
  xlabel('x'); 
  ylabel('y');
  title('Read data from a file')

%% Make some cleaning of data
% If we have same X coordinate use mean of these
