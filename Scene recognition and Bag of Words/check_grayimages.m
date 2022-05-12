clc
clear

% identify gray images in the image lists

allimages = load('traintest.mat');
all_imagenames = allimages.all_imagenames;
train_imagenames = allimages.train_imagenames;
test_imagenames = allimages.test_imagenames;

% train set
ind1=[];
for i = 1:length(train_imagenames)
    I = cell2mat(train_imagenames(i));
    img = imread(I);
    if length(size(img))==2
        ind1 = [ind1; i];
    end    
end
train_set_gray_indices = ind1
pack = load('visionRandom.mat');
trainFeatures = pack.trainFeatures;
ind2 = [];
for i = 1:size(trainFeatures, 1)
    if trainFeatures(i,1)==1
        ind2 = [ind2; i];
    end
end    
verification = ind2

% test set
ind3=[];
for i = 1:length(test_imagenames)
    I = cell2mat(test_imagenames(i));
    img = imread(I);
    if length(size(img))==2
        ind3 = [ind3; i];
    end    
end
test_set_gray_images = ind3

% all images
ind4 = [];
for i = 1:length(all_imagenames)
    I = cell2mat(all_imagenames(i));
    img = imread(I);
    if length(size(img))==2
        ind4 = [ind4; i];
    end    
end

