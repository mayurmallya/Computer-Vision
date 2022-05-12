clc
clear

img1 = imread('./data/cv_cover.jpg');
img2 = imread('./data/cv_desk.png');

[locs1, locs2] = matchPics(img1, img2);
showMatchedFeatures(img1,img2,locs1,locs2,'montage');

H2to1 = computeH_norm(locs1, locs2)


%Random points
n = 10;
P2_random = randi([250, 475], n, 2); 
% the constraint is only for visuals; you can change it, if needed
P2_random(:, 3) = ones(n, 1);
locs2 = P2_random(:, 1:2)
P1_random = zeros(size(P2_random));
for k = 1:n
    P1_random(k,:) = H2to1*(P2_random(k, :).');
    P1_random(k,:) = P1_random(k,:)/P1_random(k,3);
end
locs1 = P1_random(:, 1:2)
figure; showMatchedFeatures(img1,img2,locs1,locs2,'montage');
