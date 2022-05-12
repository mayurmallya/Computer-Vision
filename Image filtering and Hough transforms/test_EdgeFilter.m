clear;
clc;

image0 = imread('../data/img01.jpg');
imshow(image0);
size_image0 = size(image0)

sigma = 2;
img1 = myEdgeFilter(image0, sigma);

figure;
imshow(img1);
size_img1 = size(img1)

% in-built function
% figure;
% imshow(edge(image0));