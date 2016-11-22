function [text] = extractImageText(fname)
% [text] = extractImageText(fname) loads the image specified by the path 'fname'
% and returns the text contained in the image as a string.
PLOT = 0;

% Loading W and b from 3.2.1
load('nist36_model.mat','W','b');
letter_bank = {'A','B','C','D','E','F','G','H','I','J','K',...
             'L','M','N','O','P','Q','R','S','T','U','V',...
             'W','X','Y','Z','0','1','2','3','4','5','6','7',...
             '8','9'};
% Read the image
im = imread(fname);
[lines,bw] = findLetters(im);

% Put the data together
test_data = [];
for i = 1 : length(lines)
   test_line = zeros(length(lines{i}),1024);
   for j = 1 : length(lines{i})
       letter = lines{i}(j,:);
       % Find the correct letter and resize to 32*32
       im_letter = bw(letter(2):letter(4),letter(1):letter(3));
       im_letter = imresize(im_letter,[32 32]);
       test_line(j,:) = reshape(im_letter,[1,1024]);
       if (PLOT)
        figure;
        imshow(im_letter);
       end
   end
   test_data = [test_data; test_line];
end
size(test_data)
[outputs] = Classify(W, b, test_data);
outputs = mat2cell(outputs,ones(size(outputs,1),1),size(outputs,2));
group_predict = cellfun(@(x) find(x==max(x)),outputs);
text = letter_bank(group_predict);

end
