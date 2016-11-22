function [text] = extractImageText(fname)
% [text] = extractImageText(fname) loads the image specified by the path 'fname'
% and returns the next contained in the image as a string.

im = imread(fname);
[lines,bw] = findLetters(im);

for i = 1 : length(lines)
   
end

end
