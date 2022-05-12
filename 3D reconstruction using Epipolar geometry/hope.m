clc
clear

% Loading data
img1 = imread('./data/im1.png');
img2 = imread('./data/im2.png');

s = load('./data/someCorresp.mat');
M = s.M;
pts1 = s.pts1;
pts2 = s.pts2;

% Fundamental matrix
F = eightpoint(pts1, pts2, M);

i1 = double(rgb2gray(img1));
i2 = double(rgb2gray(img2));

% Given F and pts1=[x y] find matching points along epipolar line
p1_homo = [pts1, ones(size(pts1,1),1)];

window_wing = 12;
i2_pad = padarray(i2, [window_wing,window_wing], 0, 'both');

min_col_index = zeros(1,size(pts1,1));
min_row_index = zeros(1,size(pts1,1));
for i = 1:size(pts1,1)
    p1 = p1_homo(i,:);
    col1 = p1(1); row1 = p1(2);
    
    i1_patch = i1(row1-window_wing:row1+window_wing, col1-window_wing:col1+window_wing);
    
    l2 = F * p1';
    a = l2(1); b = l2(2); c = l2(3);
    %cl = 1:size(img2,2); rw = -a*cl/b -c/b;
    %figure; imshow(i2); hold on; plot(cl,rw,'b.');
    
    min_distance = 1000000;
    for col2 = 1 : size(img2,2)
        row2 = -a*col2/b -c/b;
        i2_patch = i2_pad(round(row2):round(row2)+2*window_wing, col2:col2+2*window_wing);
        % figure; imshow(i2_pad);
        distance = sqrt(sum(sum((i1_patch-i2_patch).^2)));
        if distance<=min_distance %& 30<distance
            min_distance=distance;
            min_col_index(i)=col2;
            min_row_index(i)=round(row2);
        end
    end
    a=min_distance;
end


% figure; imshow(i1); hold on; plot(pts1(:,1),pts1(:,2),'r*');
%figure; imshow(i2); hold on; plot(min_col_index, min_row_index,'b*');

%figure; imshow(i1);


