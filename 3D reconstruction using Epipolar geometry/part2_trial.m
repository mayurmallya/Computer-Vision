clc
clear

im1 = imread('./data/im1.png');
im2 = imread('./data/im2.png');
im1 = rgb2gray(im1);
im2 = rgb2gray(im2);

intrinsics = load('./data/intrinsics.mat');
K1 = intrinsics.K1;
K2 = intrinsics.K2;

extrinsics = load('./data/extrinsics.mat');
R1 = extrinsics.R1;
t1 = extrinsics.t1;
R2 = extrinsics.R2;
t2 = extrinsics.t2;

[M1, M2, K1n, K2n, R1n, R2n, t1n, t2n] = rectify_pair(K1, K2, R1, R2, t1, t2);

% [rectIL, rectIR, bbL, bbR] = warp_stereo(im1, im2, M1, M2) ;
% 
% i1 = im2double(rectIL(:,end/2+1:end));
% i2 = im2double(rectIR(:, 1:end/2));
% windowSize = 7;
% maxDisp = 15;
% dispM = get_disparity(i1, i2, maxDisp, windowSize);
% 
% imshow(i1);
% figure; imagesc(dispM.*(i1>40/255)); colormap(gray); axis image;
















