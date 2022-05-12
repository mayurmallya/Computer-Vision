clear;
clc;

image0 = imread('../data/img01.jpg');

sigma = 2;
threshold = 5;
rhoRes = 1;
thetaRes = pi/180;
nLines = 30;

%image0 = double(image0);

Im = myEdgeFilter(image0, sigma);

[H, rhoScale, thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes);
%[H2, thetaScale2, rhoScale2] = hough(Im>threshold);
%figure; imshow(uint8(H));
%figure; imshow(uint8(H2));

[rhos, thetas] = myHoughLines(H, nLines);
%peaks = houghpeaks(H2, nLines);

% xlabel('\theta'), ylabel('\rho');
% axis on, axis normal, hold on;
% plot(thetas,rhos,'s','color','white');

lines = houghlines(Im>threshold, 180*(thetaScale/pi), rhoScale, [rhos', thetas'] ,'FillGap',5,'MinLength',10);

img2 = image0;
for j=1:numel(lines)
    img2 = drawLine(img2, lines(j).point1, lines(j).point2); 
end  
imshow(img2);
    





