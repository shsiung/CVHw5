function [lines, bw] = findLetters(im)
% [lines, BW] = findLetters(im) processes the input RGB image and returns a cell
% array 'lines' of located characters in the image, as well as a binary
% representation of the input image. The cell array 'lines' should contain one
% matrix entry for each line of text that appears in the image. Each matrix entry
% should have size Lx4, where L represents the number of letters in that line.
% Each row of the matrix should contain 4 numbers [x1, y1, x2, y2] representing
% the top-left and bottom-right position of each box. The boxes in one line should
% be sorted by x1 value.
PLOT = 0;

%% Convert to black and white
bw = im(:,:,1)+im(:,:,2)+im(:,:,3);
thresh = sum(sum(bw))/(size(im,1)*size(im,2));
bw(bw<thresh) = 0;
bw(bw>=thresh) = 1;
erode_mask = strel('disk',10);  
bw = imerode(bw,erode_mask);
bw = bwareaopen(bw,10);
if (PLOT)
    imshow(bw.*255);
    imshow(im);
    hold on;
end
%% Detect letters
bw_flip = bw-1;
bw_flip(bw_flip==-1) = 1;

letter_img = bwconncomp(bw_flip,8);
boxes = regionprops(letter_img,'BoundingBox','Centroid');
num_letters = length(boxes);

avg_width = 0;
avg_height = 0;
box_posy = zeros(num_letters,1);
box_posx = zeros(num_letters,1);
for i = 1 : num_letters
    avg_width = avg_width + (boxes(i).BoundingBox(3))/num_letters;
    avg_height = avg_height + (boxes(i).BoundingBox(4))/num_letters;
    box_posy(i) = boxes(i).BoundingBox(2);
    box_posx(i) = boxes(i).BoundingBox(1);
end

%% Find lines and positions
[box_posy, ind] = sort(box_posy);
dev_y = diff(box_posy);
line_break = find(dev_y>avg_height);
lines = cell(length(line_break)+1,1);
last_index = 1;

% Sorting the boxes based on y position (find out # of lines)
for i = 1 : length(line_break)+1
    if i == length(line_break)+1
        fprintf('here');
        line = zeros(length(last_index:length(box_posy)),4);
        for j = last_index:length(box_posy)
            box = boxes(ind(j)).BoundingBox;
            line(j-last_index+1,:) = [box(1), box(2), box(1)+box(3), box(2)+box(4)];
        end
        lines(i) = mat2cell(line,size(line,1));
        break
    else
        line = zeros(length(last_index:line_break(i)),4);
        for j = last_index:line_break(i)
            box = boxes(ind(j)).BoundingBox;
            line(j-last_index+1,:) = [box(1), box(2), box(1)+box(3), box(2)+box(4)];
        end
        lines(i) = mat2cell(line,size(line,1));
    end
    last_index = line_break(i)+1;
end

% Sorting the x position in each line
for i = 1 : 
    
end
%% Draw boxes
for letter = 1:num_letters
    bb = boxes(letter).BoundingBox; %[x, y, width, height]
    if (bb(3) < avg_width/2 || bb(4) < avg_height/2)
        continue;
    end
    
    bco = boxes(letter).Centroid;
    if (PLOT)
        rectangle('Position',bb,'EdgeColor','r','LineWidth',2)
        hold on;
        plot(bco(1),bco(2),'-m+')
        drawnow;
    end
end