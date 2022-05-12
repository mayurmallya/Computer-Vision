clear;
clc;

image0 = imread('./data/img01.jpg');
imshow(image0);
size_image0 = size(image0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% convolution

% h = 1/9 * ones(3,3);
% size_h = size(h);
% [image1] = myImageFilter(image0, h);
%intensity standardization
% max_pix0 = double(max(img0(:)));
% min_pix0 = double(min(img0(:)));
% max_pix1 = double(max(img1(:)));
% min_pix1 = double(min(img1(:)));
% img1 = uint8(((img1-min_pix1)*(max_pix0-min_pix0)/(max_pix1-min_pix1))+min_pix0);
%img1 = uint8((img1-min_pix1)*255/(max_pix1-min_pix1));
% size_image1 = size(image1)
% figure;
% imshow(image1);

%img1 = conv2(img0, h);
%compare with the above output...
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% edge detection
% sigma = 2;
% img1 = myEdgeFilter(image0, sigma);
% figure;
% imshow(img1);
% size_img1 = size(img1)
% 
% figure;
% imshow(edge(image0));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% hough transform
sigma = 2;
img1 = myEdgeFilter(image0, sigma);
%figure; imshow(img1);
threshold = 80;
rho_res = 3;
theta_res = pi/180;
[H, rho_scale, theta_scale] = myHoughTransform(img1, threshold, rho_res, theta_res);
H = uint8((H-min(min(H)))*255/(max(max(H))-min(min(H))));
imshow(uint8(H));
size_H = size(H);

