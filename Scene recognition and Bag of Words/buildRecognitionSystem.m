clc
clear

% visionRandom or visionHarris

dict = load('dictionaryHarris.mat'); % two changes; line 6 and 17
dictionary = dict.dictionary;

filterBank = createFilterBank();

alldata = load('./data/traintest.mat');
train_images = alldata.train_imagenames;
train_labels = alldata.train_labels;

% K = 100;
dictionarySize = K;
pth = './results/harris_alpha50_K100/'; %remove random/harris folder from path, #SafetyFirst

trainFeatures = [];
for i = 1:length(train_images)
    i
    I = cell2mat(train_images(i));
    img = imread(I);
    Imat = I; Imat(end-2:end)='mat';
    wm = load(strcat(pth, Imat));
    wordMap = wm.wordMap;
    h = getImageFeatures(wordMap, dictionarySize);
    trainFeatures = [trainFeatures; h];
end

trainLabels = train_labels';

% save('vR/H.mat','dictnary','filterbank','trainFeatres','trainLbls');