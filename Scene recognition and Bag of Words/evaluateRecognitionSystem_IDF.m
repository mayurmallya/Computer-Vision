clc
clear

allimages = load('traintest.mat');
test_images = allimages.test_imagenames;
tl = allimages.test_labels;
test_labels = tl';

% alpha = 50, K = 100, k = 0.05
K = 100;
dictionarySize = K;

% pth = './results/harris_alpha50_K100/';
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
p2 = load('testFeatures_harris.mat');
testFeatures = p2.testFeatures_harris_alpha50_K100;

p = load('visionHarris.mat');
trainFeatures = p.trainFeatures; 
trainLabels = p.trainLabels;
% removing gray images
indx = [14 54 79 99 1048]; 
trainFeatures(1048,:)=[]; trainLabels(1048)=[];
trainFeatures(99,:)=[]; trainLabels(99)=[];
trainFeatures(79,:)=[]; trainLabels(79)=[];
trainFeatures(54,:)=[]; trainLabels(54)=[];
trainFeatures(14,:)=[]; trainLabels(14)=[];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% NN, k=1
disp('IDF check on NN')

X = trainFeatures; 

idfv = load('idf.mat');
idf = idfv.idf;
X_new = X.*repmat(idf, size(X,1), 1);
trainFeatures = X_new;

testFeatures = testFeatures.*repmat(idf, size(testFeatures,1), 1);

k = 1;
method = 'chi2'
pred_labels = [];
for i = 1:size(testFeatures, 1)
    dist = getImageDistance(testFeatures(i,:), trainFeatures, method);
    [~, ind] = mink(dist, k);
    pred = trainLabels(ind);
    maj_pred = mode(pred);
    pred_labels = [pred_labels; maj_pred];
end
acc = length(find(~(pred_labels-test_labels)))/length(pred_labels)

disp('Accuracy decreased from 54.37% to 47.50%');
disp('-------------------------------------------------');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% kNN, k=5
disp('IDF check on kNN, with k=5')

p = load('visionHarris.mat');
trainFeatures = p.trainFeatures; 
trainLabels = p.trainLabels;
% removing gray images
indx = [14 54 79 99 1048]; 
trainFeatures(1048,:)=[]; trainLabels(1048)=[];
trainFeatures(99,:)=[]; trainLabels(99)=[];
trainFeatures(79,:)=[]; trainLabels(79)=[];
trainFeatures(54,:)=[]; trainLabels(54)=[];
trainFeatures(14,:)=[]; trainLabels(14)=[];
X = trainFeatures; 
p2 = load('testFeatures_harris.mat');
testFeatures = p2.testFeatures_harris_alpha50_K100;

idfv = load('idf.mat');
idf = idfv.idf;
X_new = X.*repmat(idf, size(X,1), 1);
trainFeatures = X_new;

testFeatures = testFeatures.*repmat(idf, size(testFeatures,1), 1);

k = 5
method = 'chi2'
pred_labels = [];
for i = 1:size(testFeatures, 1)
    dist = getImageDistance(testFeatures(i,:), trainFeatures, method);
    [~, ind] = mink(dist, k);
    pred = trainLabels(ind);
    maj_pred = mode(pred);
    pred_labels = [pred_labels; maj_pred];
end
acc = length(find(~(pred_labels-test_labels)))/length(pred_labels)

disp('Accuracy decreased from 58.13% to 55.63%');

% pred = pred_labels;
% C = zeros(8,8);
% for k = 1:length(test_labels)
%     gt_label = test_labels(k);
%     p_label = pred(k);
%     C(gt_label, p_label) = C(gt_label, p_label) + 1;    
% end
% C