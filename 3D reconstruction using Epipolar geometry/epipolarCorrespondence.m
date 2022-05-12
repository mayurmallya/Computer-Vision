function [pts2] = epipolarCorrespondence(img1, img2, F, pts1)
% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2
%

i1 = double(rgb2gray(img1));
i2 = double(rgb2gray(img2));

% Given F and pts1=[x y] find matching points along epipolar line
p1_homo = [pts1, ones(size(pts1,1),1)];

window_wing = 10;
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
    pts2 = [min_col_index', min_row_index'];
end


% img1 = rgb2gray(img1);
% img2 = rgb2gray(img2);
% I1 = im2double(img1);
% I2 = im2double(img2);
% 
% pts1_hom = [pts1, ones(size(pts1,1),1)];
% l2 = F * pts1_hom';
% 
% window_size = 11;
% scale = (window_size-1)/2;
% I1 = padarray(I1, [scale,scale], 0, 'both');
% I2 = padarray(I2, [scale,scale], 0, 'both');
% 
% pts2 = zeros(size(pts1));
% for i = 1:size(pts1,1)
%     col1 = pts1(i,1);%col
%     row1 = pts1(i,2);%row
%     
%     a = l2(1,i);
%     b = l2(2,i);
%     c = l2(3,i);
%     
%     correspondence_points = size(img2,2);
%     col2_array = 1:size(img1,2);
%     row2_array = (-a*col2_array - c)/b;
%     
%     I1_patch = I1(col1:col1+2*scale, row1:row1+2*scale, :);
%     
%     min_eucld_dist = 9999;
%     min_index = 0;
%     for j = 1:correspondence_points
%         col2 = col2_array(j);
%         row2 = round(row2_array(j));
%         I2_patch = I2(col2:col2+2*scale, row2:row2+2*scale, :);
%         eucld_dist = sum(sum(sum(I1_patch-I2_patch).^2));
%         if eucld_dist < min_eucld_dist
%             min_eucld_dist = eucld_dist;
%             min_index = j;
%         end
%     end
%     best_col2 = col2_array(min_index);
%     best_row2 = row2_array(min_index);
%     pts2(i,:) = [best_col2, best_row2];
% end
    
% pts1(:,3) = 1;
% l2 = F * pts1';
% 
% window_size = 11;
% scale = (window_size-1)/2;
% I1 = padarray(I1, [scale,scale], 100, 'both');
% I2 = padarray(I2, [scale,scale], 100, 'both');
% 
% pts2 = zeros(size(pts1,1),2);
% for i = 1:size(pts1,1)
%     x1 = pts1(i,1);%col
%     y1 = pts1(i,2);%row
%     
%     a = l2(1,i);
%     b = l2(2,i);
%     c = l2(3,i);
%     
%     correspondence_points = size(img1,2);
%     x2_array = 1:size(img1,2);
%     y2_array = (-a*x2_array - c)/b;
%     
%     I1_patch = I1(y1-scale:y1+scale, x1-scale:x1+scale, :);
%     
%     min_eucld_dist = 9999;
%     min_index = 0;
%     for j = 1:correspondence_points
%         x2 = x2_array(j)+scale;
%         y2 = round(y2_array(j))+scale;
%         I2_patch = I2(y2-scale:y2+scale, x2-scale:x2+scale, :);
%         eucld_dist = sum(sum(sum(I1_patch-I2_patch).^2));
%         if eucld_dist < min_eucld_dist
%             min_eucld_dist = eucld_dist;
%             min_index = j;
%         end
%     end
%     best_x2 = x2_array(min_index);
%     best_y2 = y2_array(min_index);
%     pts2(i,:) = [best_x2, best_y2];
% end
%         