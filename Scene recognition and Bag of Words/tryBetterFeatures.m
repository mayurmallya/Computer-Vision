clc
clear

allimages = load('traintest.mat');
tl = allimages.test_labels;
test_labels = tl';

% alpha = 50, K = 100, k = 0.05
K = 100;
dictionarySize = K;

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

X = trainFeatures; 
Y = trainLabels;

% idfv = load('idf.mat');
% idf = idfv.idf;
% X_new = X.*repmat(idf, size(X,1), 1);
% trainFeatures = X_new;
% testFeatures = testFeatures.*repmat(idf, size(testFeatures,1), 1);
% X=trainFeatures;

disp('Harris method features; Linear kernel');
t = templateSVM('Standardize',true,'KernelFunction','linear');
options = statset('UseParallel',true);
M = fitcecoc(X,Y,'Learners',t,'Options',options);
pred = predict(M, testFeatures);
accuracy = length(find(~(pred-test_labels)))/length(pred)

C = zeros(8,8);
for k = 1:length(test_labels)
    gt_label = test_labels(k);
    p_label = pred(k);
    C(gt_label, p_label) = C(gt_label, p_label) + 1;    
end
C
