fid =fopen('results.txt', 'w');

% For all persons in the database
for i =1:108
    
  str = strcat(pwd, '/images/', sprintf('%03d',i), '_1_1.bmp');
% Create the iris-code and mask
  [code, mask] = createiristemplate(str);

% For all the remaining persons in the database
  for j = (i+1):108
        compstr = strcat(pwd, '/images/', sprintf('%03d',j), '_1_1.bmp');
% Create the iris-code and mask
        [compcode, compmask] = createiristemplate(compstr);
% Get the Hamming distance for the pair
        dist = gethammingdistance(code, mask, compcode, compmask, 1);
% Write the distance to the file
        out = strcat(sprintf('%03d',i), '|', sprintf('%03d', j), '|', num2str(dist));
        fprintf(fid, '%s\n', out);
  end

end
fclose(fid);
