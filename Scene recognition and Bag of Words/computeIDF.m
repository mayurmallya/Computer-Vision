clc
clear

% pth = './results/random_alpha50_K100/';
% allimages = load('traintest.mat');
% test_images = allimages.test_imagenames;
% i=1;
% I = cell2mat(test_images(i));
% img = imread(I);
% Imat = I; Imat(end-2:end)='mat';
% wm = load(strcat(pth, Imat));
% wordMap = wm.wordMap;
% h = getImageFeatures(wordMap, 100);

p = load('visionHarris.mat');
trainFeatures = p.trainFeatures; 
% removing gray images
indx = [14 54 79 99 1048]; 
trainFeatures(1048,:)=[]; 
trainFeatures(99,:)=[]; 
trainFeatures(79,:)=[]; 
trainFeatures(54,:)=[]; 
trainFeatures(14,:)=[]; 

tf = trainFeatures; 

idf = zeros(1, size(tf,2));
freq = zeros(1, size(tf,2));
T = size(tf, 1);

for i = 1:size(tf,2)
    a = tf(:,i);
    d = length(find(a));
    freq(i) = d;
    idf(i) = log(T/d);
end    