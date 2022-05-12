function [ locs1, locs2] = matchPics( img1, img2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!

% Convert images to grayscale, if necessary
if (ndims(img1) == 3)
   img1 = rgb2gray(img1);
end

if (ndims(img2) == 3)
   img2= rgb2gray(img2);
end
% SHOULD I BLUR THE IMAGES BEFORE DETECTING FEATURES ???

% Detect features in both images
points1 = detectFASTFeatures(img1);
size_points1 = size(points1);
points2 = detectFASTFeatures(img2);
size_points2 = size(points2);
number_of_features = 250; % try without strongSelect, ie use all points
points1 = points1.selectStrongest(number_of_features);
points2 = points2.selectStrongest(number_of_features);
%figure; imshow(img1); hold on; plot(points1);
%figure; imshow(img2); hold on; plot(points2);

% Obtain descriptors for the computed feature locations
[desc1, locs1] = computeBrief(img1, points1.Location);
[desc2, locs2] = computeBrief(img2, points2.Location);

% Match features using the descriptors
indexPairs = matchFeatures(desc1,desc2, 'MatchThreshold', 10.0, 'MaxRatio', 0.7);
locs1 = locs1(indexPairs(:,1),:);
locs2 = locs2(indexPairs(:,2),:);
end

