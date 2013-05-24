fid =fopen('results.txt', 'w');
d = dir(strcat(pwd, '/images/'));

files = cell(108, 7);
for i=1:108
    for n = 1:7
        files{i}{n} = 'string';
    end
end

for f = 1:length(d)
    fname = d(f).name;
    str = strcat(pwd, '/images/', fname);
    if (regexp(fname, '.{7}\.bmp$'))
        %fprintf(fid, '%s\n', fname);
        %[code, mask] = createiristemplate(str);
        
        number = str2double(fname(1:3));
        subset = files{number};
        
        day = str2double(fname(5:5));
        shot = str2double(fname(7:7));
                
        subset{(day -1 ) * 3 + shot} = fname
        files{number} = subset;        
    end
end

for person = 1:108
    for pic = 1:7
        [code, mask] = createiristemplate(files{person}{pic});
        for match = pic+1:7
            [compcode, compmask] = createiristemplate(files{person}{match});
            dist = gethammingdistance(code, mask, compcode, compmask, 8);
            out = strcat(files{person}{pic}, '|', files{person}{match}, '|', num2str(dist));
            fprintf(fid, '%s\n', out);
        end
    end
end
