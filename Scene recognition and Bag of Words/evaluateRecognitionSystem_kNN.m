clc
clear

allimages = load('traintest.mat');
test_images = allimages.test_imagenames;
tl = allimages.test_labels;
test_labels = tl';

% alpha = 50, K = 100, k = 0.05
K = 100;
dictionarySize = K;

% Best combination- Harris dictionary with Chi2 metric

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

disp('Harris dictionary with Chi-square distance');
method = 'chi2'; % change here

accuracy = [];
for k = 1:40
    pred_labels = [];
    for i = 1:size(testFeatures, 1)
        dist = getImageDistance(testFeatures(i,:), trainFeatures, method);
        [~, ind] = mink(dist, k);
        pred = trainLabels(ind);
        maj_pred = mode(pred);
        pred_labels = [pred_labels; maj_pred];
    end
    acc = length(find(~(pred_labels-test_labels)))/length(pred_labels);
    accuracy = [accuracy; acc];
end


plot(1:40, accuracy, '-r*');
grid on;
xlabel('k'); ylabel('Accuracy');
title('Accuracy of kNN with value of k');

% [max_accuracy, k] = max(accuracy)
disp('k=5 and k=7 have same accuracies');
disp('Resolving the ties by comparing the neighboring accuracies (moving averages)');
k = 7
pred_labels = [];
for i = 1:size(testFeatures, 1)
    dist = getImageDistance(testFeatures(i,:), trainFeatures, method);
    [~, ind] = mink(dist, k);
    pred = trainLabels(ind);
    maj_pred = mode(pred);
    pred_labels = [pred_labels; maj_pred];
end
acc = length(find(~(pred_labels-test_labels)))/length(pred_labels)

C = zeros(8,8);
for k = 1:length(test_labels)
    gt_label = test_labels(k);
    p_label = pred_labels(k);
    C(gt_label, p_label) = C(gt_label, p_label) + 1;    
end
C

disp('OR k=5 moving avg with 1 neighbor');