clear;
clc;

image0 = imread('../data/img01.jpg');

sigma = 2;
threshold = 5;
rhoRes = 3;
thetaRes = pi/180;
nLines = 25;

%image0 = double(image0);

Im = myEdgeFilter(image0, sigma);

[H, rhoScale, thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes);
%[H2, thetaScale2, rhoScale2] = hough(Im>threshold);
figure; imshow(uint8(H));
%figure; imshow(uint8(H2));

[rhos, thetas] = myHoughLines(H, nLines);
%peaks = houghpeaks(H2, nLines);

% following code is from a matlab example
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
plot(thetas,rhos,'s','color','white');