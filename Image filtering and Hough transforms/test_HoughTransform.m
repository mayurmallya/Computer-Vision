clear;
clc;

image0 = imread('../data/img01.jpg');
imshow(image0);
size_image0 = size(image0);

% hough transform

% edge detection
sigma = 2;
img1 = myEdgeFilter(image0, sigma);
%figure; imshow(img1);

% HT parameters
threshold = 8;
rho_res = 3;
theta_res = pi/180;

% HT
[H, rho_scale, theta_scale] = myHoughTransform(img1, threshold, rho_res, theta_res);

H = uint8((H-min(min(H)))*255/(max(max(H))-min(min(H))));
figure;
imshow(uint8(H));
xlabel('\theta'), ylabel('\rho');

size_H = size(H);