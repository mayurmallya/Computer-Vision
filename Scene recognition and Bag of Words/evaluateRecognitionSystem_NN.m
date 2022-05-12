clc
clear

allimages = load('traintest.mat');
test_images = allimages.test_imagenames;
tl = allimages.test_labels;
test_labels = tl';

% alpha = 50, K = 100, k = 0.05
K = 100;
dictionarySize = K;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RANDOM dictionary for euclidean distance

% pth = './results/random_alpha50_K100/';
% 
% testFeatures = [];
% for i = 1:length(test_images)
%     I = cell2mat(test_images(i));
%     img = imread(I);
%     Imat = I; Imat(end-2:end)='mat';
%     wm = load(strcat(pth, Imat));
%     wordMap = wm.wordMap;
%     h = getImageFeatures(wordMap, dictionarySize);
%     testFeatures = [testFeatures; h];
% end
% 
% pack = load('visionRandom.mat'); % change here
% trainFeatures = pack.trainFeatures;
% trainLabels = pack.trainLabels;
% 
% % removing gray images
% indx = [14 54 79 99 1048]; 
% trainFeatures(1048,:)=[]; trainLabels(1048)=[];
% trainFeatures(99,:)=[]; trainLabels(99)=[];
% trainFeatures(79,:)=[]; trainLabels(79)=[];
% trainFeatures(54,:)=[]; trainLabels(54)=[];
% trainFeatures(14,:)=[]; trainLabels(14)=[];
% 
% disp('Random dictionary with Euclidean distance');
% method = 'euclidean'; % change here
% pred_labels = [];
% for i = 1:size(testFeatures, 1)
%     dist = getImageDistance(testFeatures(i,:), trainFeatures, method);
%     [~, ind] = min(dist);
%     pred = trainLabels(ind);
%     pred_labels = [pred_labels; pred];
% end
% 
% accuracy = length(find(~(pred_labels-test_labels)))/length(pred_labels)
% 
% C = zeros(8,8);
% for k = 1:length(test_labels)
%     gt_label = test_labels(k);
%     p_label = pred_labels(k);
%     C(gt_label, p_label) = C(gt_label, p_label) + 1;    
% end
% C
% disp('-----------------------------------------------');
% 
% disp('Random dictionary with Chi-square distance');
% method = 'chi2'; % change here
% pred_labels = [];
% for i = 1:size(testFeatures, 1)
%     dist = getImageDistance(testFeatures(i,:), trainFeatures, method);
%     [~, ind] = min(dist);
%     pred = trainLabels(ind);
%     pred_labels = [pred_labels; pred];
% end
% 
% accuracy = length(find(~(pred_labels-test_labels)))/length(pred_labels)
% 
% C = zeros(8,8);
% for k = 1:length(test_labels)
%     gt_label = test_labels(k);
%     p_label = pred_labels(k);
%     C(gt_label, p_label) = C(gt_label, p_label) + 1;    
% end
% C
disp('----------------------------------------------');

% HARRIS dictionary for euclidean distance

pth = './results/harris_alpha50_K100/'; 

testFeatures = [];
for i = 1:length(test_images)
    I = cell2mat(test_images(i));
    img = imread(I);
    Imat = I; Imat(end-2:end)='mat';
    wm = load(strcat(pth, Imat));
    wordMap = wm.wordMap;
    h = getImageFeatures(wordMap, dictionarySize);
    testFeatures = [testFeatures; h];
end

pack = load('visionHarris.mat'); % change here
trainFeatures = pack.trainFeatures;
trainLabels = pack.trainLabels;

% removing gray images
indx = [14 54 79 99 1048]; 
trainFeatures(1048,:)=[]; trainLabels(1048)=[];
trainFeatures(99,:)=[]; trainLabels(99)=[];
trainFeatures(79,:)=[]; trainLabels(79)=[];
trainFeatures(54,:)=[]; trainLabels(54)=[];
trainFeatures(14,:)=[]; trainLabels(14)=[];

disp('Harris dictionary with Euclidean distance');
method = 'euclidean'; % change here
pred_labels = [];
for i = 1:size(testFeatures, 1)
    dist = getImageDistance(testFeatures(i,:), trainFeatures, method);
    [~, ind] = min(dist);
    pred = trainLabels(ind);
    pred_labels = [pred_labels; pred];
end

accuracy = length(find(~(pred_labels-test_labels)))/length(pred_labels)

C = zeros(8,8);
for k = 1:length(test_labels)
    gt_label = test_labels(k);
    p_label = pred_labels(k);
    C(gt_label, p_label) = C(gt_label, p_label) + 1;    
end
C
disp('-----------------------------------------------');

disp('Harris dictionary with Chi-square distance');
method = 'chi2'; % change here
pred_labels = [];
for i = 1:size(testFeatures, 1)
    dist = getImageDistance(testFeatures(i,:), trainFeatures, method);
    [~, ind] = min(dist);
    pred = trainLabels(ind);
    pred_labels = [pred_labels; pred];
end

accuracy = length(find(~(pred_labels-test_labels)))/length(pred_labels)

C = zeros(8,8);
for k = 1:length(test_labels)
    gt_label = test_labels(k);
    p_label = pred_labels(k);
    C(gt_label, p_label) = C(gt_label, p_label) + 1;    
end
C
disp('----------------------------------------------');













