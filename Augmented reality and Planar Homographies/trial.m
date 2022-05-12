clc
clear

img1 = imread('./data/hp_cover.jpg');
img2 = imread('./data/hp_desk.png');

[locs1, locs2] = matchPics(img1, img2);
showMatchedFeatures(img1,img2,locs1,locs2,'montage');

% H2to1 = computeH(locs1, locs2)
% %Random points
% n = 10;
% P2_random = randi([250, 475], n, 2);
% P2_random(:, 3) = ones(n, 1);
% locs2 = P2_random(:, 1:2)
% P1_random = zeros(size(P2_random));
% for k = 1:n
%     P1_random(k, :) = H2to1*(P2_random(k, :).');
%     P1_random(k,:) = P1_random(k,:)/P1_random(k,3);
% end
% locs1 = P1_random(:, 1:2)
% figure; showMatchedFeatures(img2,img1,locs2,locs1,'montage');
% 
% H2to1 = computeH_norm(locs1, locs2)
% %Random points
% n = 7;
% P2_random = randi([250, 475], n, 2);
% P2_random(:, 3) = ones(n, 1);
% locs2 = P2_random(:, 1:2)
% P1_random = zeros(size(P2_random));
% for k = 1:n
%     P1_random(k,:) = H2to1*(P2_random(k, :).');
%     P1_random(k,:) = P1_random(k,:)/P1_random(k,3);
% end
% locs1 = P1_random(:, 1:2)
% figure; showMatchedFeatures(img2,img1,locs2,locs1,'montage');

%H2to1_ = computeH_norm(locs1, locs2)

[bestH2to1, inliers] = computeH_ransac(locs1, locs2);

P2 = locs2(inliers,:);
P2(:, 3) = ones(sum(inliers), 1);
locs2 = P2(:, 1:2);
P1 = zeros(size(P2));
for k = 1:sum(inliers)
    P1(k,:) = bestH2to1*(P2(k, :).');
    P1(k,:) = P1(k,:)/P1(k,3);
end
locs1 = P1(:, 1:2);
figure; showMatchedFeatures(img2,img1,locs2,locs1,'montage');


