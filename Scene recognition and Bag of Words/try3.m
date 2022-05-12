clc
clear

pack = load('visionHarris.mat');
hs = pack.trainFeatures;

hist1 = hs(2,:);
histSet = hs;
method = 'chi2'; %euclidean or chi2
dist = getImageDistance(hist1, histSet, method);

