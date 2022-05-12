function [points] = getHarrisPoints(I, alpha, k)

grayimg = im2double(rgb2gray(I));
grayimg = padarray(grayimg, [2, 2], 'replicate');

hx = [1 0 -1; 2 0 -2; 1 0 -1];
Ix = conv2(grayimg, hx, 'same'); Ix = Ix(3:end-2, 3:end-2);
hy = [1 2 1; 0 0 0; -1 -2 -1];
Iy = conv2(grayimg, hy, 'same'); Iy = Iy(3:end-2, 3:end-2);

Ixx = Ix.*Ix;
Ixy = Ix.*Iy;
Iyx = Iy.*Ix;
Iyy = Iy.*Iy;

kernel = ones(3,3);
M11 = conv2(Ixx, kernel, 'same');
M12 = conv2(Ixy, kernel, 'same');
M21 = conv2(Iyx, kernel, 'same');
M22 = conv2(Iyy, kernel, 'same');

R = (M11.*M22 - M12.*M21) - k * (M11 + M22).^2;

% NMS
k_size = 3;
scale = (k_size-1)/2;


[r, c] = size(R);
R = padarray(R, [scale, scale], 'replicate');
NMS_R = zeros(size(R));
for i = scale+1 : scale+r 
    for j = scale+1 : scale+c
        patch = R(i-scale:i+scale, j-scale:j+scale);
        if R(i,j) == max(max(patch))
            NMS_R(i,j) = R(i,j);
        end
    end
end
NMS_R = NMS_R(scale+1:scale+r, scale+1:scale+c);

% R = padarray(R, [scale, scale]);
% NMS_R = R;
% [R_row, R_col] = size(R);
% for i = scale+1 : R_row-scale
%     for j = scale+1 : R_col-scale
%         conv = R(i-scale:i+scale, j-scale:j+scale);
%         if conv(scale+1,scale+1) < max(conv(:))
%             NMS_R(i,j) = 0;
%         end    
%     end
% end
% NMS_R = NMS_R(scale+1:end-scale, scale+1:end-scale);

R_array = reshape(NMS_R, 1, []);
[~, index] = maxk(R_array, alpha);
[row, col] = ind2sub(size(NMS_R), index);

points = [col', row'];