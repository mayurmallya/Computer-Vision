clc
clear

layers = get_lenet();
load lenet.mat
% load data
% Change the following value to true to load the entire dataset.
fullset = true;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);
xtrain = [xtrain, xvalidate];
ytrain = [ytrain, yvalidate];
m_train = size(xtrain, 2);
batch_size = 64;
 
layers{1}.batch_size = 1;
img = xtest(:, 1);
img = reshape(img, 28, 28);
imshow(img'); figure;
 
%[cp, ~, output] = conv_net_output(params, layers, xtest(:, 1), ytest(:, 1));
output = convnet_forward(params, layers, xtest(:, 1));
output_1 = reshape(output{1}.data, 28, 28);
% Fill in your code here to plot the features.

output_2 = reshape(output{2}.data, output{2}.height, output{2}.width, output{2}.channel);
% maximum = max(output_2(:));
% minimum = min(output_2(:));
sgtitle('Conv-1 layer outputs');
hold on;
for i = 1:output{2}.channel
    subplot(4,5,i)
    img = output_2(:,:,i)';
    imshow(img,[]);
%     imshow(img,[minimum,maximum]);
end    

figure;
sgtitle('ReLU-1 layer outputs');
hold on;
output_3 = reshape(output{3}.data, output{3}.height, output{3}.width, output{3}.channel);
for i = 1:output{3}.channel
    subplot(4,5,i)
    i2 = output_2(:,:,i)';
    img = output_3(:,:,i)';
    imshow(img,[min(i2(:)), max(i2(:))]);
%     imshow(img, [minimum,maximum]);
end   



