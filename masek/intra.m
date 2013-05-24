% Open output file
fid =fopen('results.txt', 'w');
% assuming the input images are in pwd/images/ get the directory
d = dir(strcat(pwd, '/images/'));

% Initialize two-dimensional array of cells where the filenames are stored in classes
files = cell(108, 7);
for i=1:108
    for n = 1:7
        files{i}{n} = 'string';
    end
end

% For each file in the directory
for f = 1:length(d)
    fname = d(f).name;
    str = strcat(pwd, '/images/', fname);
% skip files which don't match the filenames .{7}.bmp$ which are the files which are written when analysing the image for the first time
    if (regexp(fname, '.{7}\.bmp$'))
        
        number = str2double(fname(1:3));
        subset = files{number};
        
        day = str2double(fname(5:5));
        shot = str2double(fname(7:7));
                
% Store the filename in the according field of the array
        subset{(day -1 ) * 3 + shot} = fname;
        files{number} = subset;        
    end
end

% For every person in the test case
for person = 1:108
% For every picture of a person
    for pic = 1:7
% Create the iris code
        [code, mask] = createiristemplate(strcat(pwd, '/images/', files{person}{pic}));
% Compare with the remaining pictures of the person's eye
        for match = pic+1:7
            [compcode, compmask] = createiristemplate(strcat(pwd, '/images/', files{person}{match}));
            dist = gethammingdistance(code, mask, compcode, compmask, 1);
% Write the hamming distance to the output file
            out = strcat(files{person}{pic}, '|', files{person}{match}, '|', num2str(dist));
            fprintf(fid, '%s\n', out);
        end
    end
end

close(fid);
