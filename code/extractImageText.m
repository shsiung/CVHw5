function [text] = extractImageText(fname)
% [text] = extractImageText(fname) loads the image specified by the path 'fname'
% and returns the text contained in the image as a string.
PLOT = 0;

% Loading W and b from 3.2.1
load('nist36_model_3.mat','W','b');
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
       % Also, padding around the image with 1's
       letter_width = letter(3) - letter(1);
       letter_height = letter(4) - letter(2);
       im_letter = bw(letter(2):letter(4),letter(1):letter(3));
       wh_diff = abs(letter_width - letter_height);
       if letter_width > letter_height
           new_im_letter = ones(letter_width+1,letter_width+1);
           new_im_letter((wh_diff/2):(wh_diff/2)+letter_height ,1:letter_width+1) =...
               im_letter;
       elseif letter_height > letter_width
           new_im_letter = ones(letter_height+1,letter_height+1);
           new_im_letter(1:letter_height+1 ,(wh_diff/2):(wh_diff/2)+letter_width) =...
               im_letter;
       end
       new_im_letter = bwareaopen(new_im_letter,100);
       im_letter = imresize(new_im_letter,[32 32]);
       test_line(j,:) = reshape(im_letter,[1,1024]);
       if (PLOT)
        figure;
        imshow(new_im_letter.*255);
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
