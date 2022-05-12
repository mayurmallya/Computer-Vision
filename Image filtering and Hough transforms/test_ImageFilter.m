clc;
clear;

% img0
img0 = imread('../data/img02.jpg');
imshow(img0);
size_img0 = size(img0)

% convolution kernels

%box kernel
h = 1/49 * ones(7,7);
[img1] = myImageFilter(img0, h);
size_img1 = size(img1)
% intensity standardization
max_pix0 = double(max(img0(:)));
min_pix0 = double(min(img0(:)));
max_pix1 = double(max(img1(:)));
min_pix1 = double(min(img1(:)));
img1 = uint8(((img1-min_pix1)*(max_pix0-min_pix0)/(max_pix1-min_pix1))+min_pix0);
figure;
imshow(img1);

%gaussian kernel
h = 1/256 * [1 4 6 4 1; 4 16 24 16 4; 6 24 36 24 6; 4 16 24 16 4; 1 4 6 4 1];
[img1] = myImageFilter(img0, h);
size_img2 = size(img1)
max_pix0 = double(max(img0(:)));
min_pix0 = double(min(img0(:)));
max_pix1 = double(max(img1(:)));
min_pix1 = double(min(img1(:)));
img1 = uint8(((img1-min_pix1)*(max_pix0-min_pix0)/(max_pix1-min_pix1))+min_pix0);
figure;
imshow(img1);