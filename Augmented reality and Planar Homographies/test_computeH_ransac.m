clc
clear


img1 = imread('./data/cv_cover.jpg');
img2 = imread('./data/cv_desk.png');

[locs1, locs2] = matchPics(img1, img2);
showMatchedFeatures(img1,img2,locs1,locs2,'montage');

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
figure; showMatchedFeatures(img1,img2,locs1,locs2,'montage');