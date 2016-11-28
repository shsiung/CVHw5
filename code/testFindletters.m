function testFindLetters()
% Strings must be the same length...
file_name = ['../images/01_list.jpg   ';...
            '../images/02_letters.jpg';...
            '../images/03_haiku.jpg  ';...
            '../images/04_deep.jpg   '];
file_name = cellstr(file_name);
for i = 1 : length(file_name)
im = imread(file_name{i});
figure
findLetters(im);
end

end