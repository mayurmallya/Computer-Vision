% Your solution to Q2.1.5 goes here!
clc
clear
img1 = imread('./data/cv_cover.jpg');

% Read the image and convert to grayscale, if necessary
if (ndims(img1) == 3)
   img1 = rgb2gray(img1);
end

% Compute the features and descriptors [BRIEF]
points1 = detectFASTFeatures(img1);
size_points1 = size(points1);
[desc1, locs1] = computeBrief(img1, points1.Location);
theta = 10;
h = zeros(1,37);
for i = 0:36
    % Rotate image
    img2 = imrotate(img1, i*theta);
    % Compute features and descriptors
    points2 = detectFASTFeatures(img2);
    size_points2 = size(points2);
    [desc2, locs2] = computeBrief(img2, points2.Location);
    % Match features
    indexPairs = matchFeatures(desc1,desc2, 'MatchThreshold', 10.0, 'MaxRatio', 0.8);
    locs_1 = locs1(indexPairs(:,1),:);
    locs_2 = locs2(indexPairs(:,2),:);
    % Update histogram
    h(i+1) = length(locs_1);
end
% Display histogram
x = 0:10:360;
bar(x, h);xlabel('\theta');

figure;
% Compute the features and descriptors [SURF]
points1 = detectSURFFeatures(img1);
size_points1 = size(points1);
[desc1, locs1] = extractFeatures(img1, points1.Location, 'Method', 'SURF');
theta = 10;
h = zeros(1,37);
for i = 0:36
    % Rotate image
    img2 = imrotate(img1, i*theta);
    % Compute features and descriptors
    points2 = detectSURFFeatures(img2);
    size_points2 = size(points2);
    [desc2, locs2] = extractFeatures(img2, points2.Location, 'Method', 'SURF');
    % Match features
    indexPairs = matchFeatures(desc1,desc2, 'MatchThreshold', 10.0, 'MaxRatio', 0.8);
    locs_1 = locs1(indexPairs(:,1),:);
    locs_2 = locs2(indexPairs(:,2),:);
    % Update histogram
    h(i+1) = length(locs_1);
end
% Display histogram
x = 0:10:360;
bar(x, h);xlabel('\theta');
