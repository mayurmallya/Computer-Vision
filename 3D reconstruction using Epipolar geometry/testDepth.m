clc
clear all ;
% Load image and paramters
im1 = imread('./data/im1.png');
im2 = imread('./data/im2.png');
im1 = rgb2gray(im1);
% imshow(im1);
im2 = rgb2gray(im2);
% figure; imshow(im2);
load('rectify.mat', 'M1', 'M2', 'K1n', 'K2n', 'R1n', 'R2n', 't1n', 't2n');

maxDisp = 20; 
windowSize = 3;
dispM = get_disparity(im1, im2, maxDisp, windowSize);
figure; imagesc(dispM.*(im1>40)); colormap(gray); axis image;
% --------------------  get depth map
depthM = get_depth(dispM, K1n, K2n, R1n, R2n, t1n, t2n);
figure; imagesc(depthM.*(im1>40)); colormap(gray); axis image;

% For rectified input

[rectIL, rectIR, bbL, bbR] = warp_stereo(im1, im2, M1, M2) ;
im1 = rectIL(:,end/2+1:end); %+1
% figure; imshow(im1);
im2 = rectIR(:, 1:end/2); %0
% figure; imshow(im2);

maxDisp = 20; 
windowSize = 3;
dispM = get_disparity(im1, im2, maxDisp, windowSize);
figure; imagesc(dispM.*(im1>40)); colormap(gray); axis image;
% --------------------  get depth map
depthM = get_depth(dispM, K1n, K2n, R1n, R2n, t1n, t2n);
figure; imagesc(depthM.*(im1>40)); colormap(gray); axis image;



