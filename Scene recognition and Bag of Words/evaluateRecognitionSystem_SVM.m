clc
clear

allimages = load('traintest.mat');
% test_images = allimages.test_imagenames;
tl = allimages.test_labels;
test_labels = tl';

% alpha = 50, K = 100, k = 0.05
K = 100;
dictionarySize = K;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Random

p1 = load('testFeatures_random.mat');
testFeatures = p1.testFeatures_random_alpha50_K100;

p = load('visionRandom.mat');
% % % dictionary=p.dictionary;
% % % filterBank=p.filterBank;
% % % trainFeatures=p.trainFeatures;
% % % trainLabels=p.trainLabels;
% % % save('visionSVM_random.mat', 'dictionary','filterBank','trainFeatures','trainLabels');
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

disp('Random method features; Polynomial degree 7 kernel');
t = templateSVM('KernelFunction','polynomial', 'PolynomialOrder',7);
options = statset('UseParallel',true);
M = fitcecoc(X,Y,'Learners',t,'Options',options);
pred = predict(M, testFeatures);
accuracy = length(find(~(pred-test_labels)))/length(pred)

disp('--------------------------------------------------');
% C = zeros(8,8);
% for k = 1:length(test_labels)
%     gt_label = test_labels(k);
%     p_label = pred(k);
%     C(gt_label, p_label) = C(gt_label, p_label) + 1;    
% end
% C

disp('Random method features; Gaussian/RBF kernel');
t = templateSVM('KernelFunction','gaussian');
options = statset('UseParallel',true);
M = fitcecoc(X,Y,'Learners',t,'Options',options);
pred = predict(M, testFeatures);
accuracy = length(find(~(pred-test_labels)))/length(pred)
disp('--------------------------------------------------');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Harris
% % pth = './results/harris_alpha50_K100/';
% % testFeatures = [];
% % for i = 1:length(test_images)
% %     I = cell2mat(test_images(i));
% %     img = imread(I);
% %     Imat = I; Imat(end-2:end)='mat';
% %     wm = load(strcat(pth, Imat));
% %     wordMap = wm.wordMap;
% %     h = getImageFeatures(wordMap, dictionarySize);
% %     testFeatures = [testFeatures; h];
% % end
p2 = load('testFeatures_harris.mat');
testFeatures = p2.testFeatures_harris_alpha50_K100;

p = load('visionHarris.mat');
% dictionary=p.dictionary;
% filterBank=p.filterBank;
% trainFeatures=p.trainFeatures;
% trainLabels=p.trainLabels;
% save('visionSVM_Harris.mat', 'dictionary','filterBank','trainFeatures','trainLabels');

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
disp('Harris method features; Polynomial degree 7 kernel');
t = templateSVM('KernelFunction','polynomial', 'PolynomialOrder',7);
options = statset('UseParallel',true);
M = fitcecoc(X,Y,'Learners',t,'Options',options);
pred = predict(M, testFeatures);
accuracy = length(find(~(pred-test_labels)))/length(pred)
disp('--------------------------------------------------');

% C = zeros(8,8);
% for k = 1:length(test_labels)
%     gt_label = test_labels(k);
%     p_label = pred(k);
%     C(gt_label, p_label) = C(gt_label, p_label) + 1;    
% end
% C

disp('Harris method features; Gaussian/RBF kernel');
t = templateSVM('KernelFunction','gaussian');
options = statset('UseParallel',true);
M = fitcecoc(X,Y,'Learners',t,'Options',options);
pred = predict(M, testFeatures);
accuracy = length(find(~(pred-test_labels)))/length(pred)





