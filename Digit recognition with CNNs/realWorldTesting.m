clc
clear

% Training images have black background = 0 = min
% Foreground is white = 1 = max

% % Network defintion
layers = get_lenet();
% % Loading data
% fullset = false;
% [xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);
% % load the trained weights
load lenet.mat

i11 = imread('./images/zero.jpg'); 
i12 = 255-i11;
i13 = ones(size(i12)).*(150<i12);
i14 = rgb2gray(i13);
i15 = i14';
i16 = imresize(i15,[28,28]);
i17 = im2double(i16);
input1 = reshape(i17, 28*28, 1);

i21 = imread('./images/three.jpeg'); 
i22 = 255-i21;
i23 = ones(size(i22)).*(150<i22);
i24 = rgb2gray(i23);
i25 = i24';
i26 = imresize(i25,[28,28]);
i27 = im2double(i26);
input2 = reshape(i27, 28*28, 1);

i31 = imread('./images/six.jpeg'); 
i32 = 255-i31;
i33 = ones(size(i32)).*(150<i32);
i34 = rgb2gray(i33);
i35 = i34';
i36 = imresize(i35,[28,28]);
i37 = im2double(i36);
input3 = reshape(i37, 28*28, 1);

i41 = imread('./images/seven.jpg'); 
i42 = 255-i41;
i43 = ones(size(i42)).*(150<i42);
i44 = rgb2gray(i43);
i45 = i44';
i46 = imresize(i45,[28,28]);
i47 = im2double(i46);
input4 = reshape(i47, 28*28, 1);

i51 = imread('./images/eight.jpeg'); 
i52 = 255-i51;
i53 = ones(size(i52)).*(150<i52);
i54 = rgb2gray(i53);
i55 = i54';
i56 = imresize(i55,[28,28]);
i57 = im2double(i56);
input5 = reshape(i57, 28*28, 1);

layers{1}.batch_size = 5;
inputs = [input1, input2, input3, input4, input5];
[output, P] = convnet_forward(params, layers, inputs);

[prob,ind] = maxk(P,3); 

act = [0 3 6 7 8];

images(:,:,1)=reshape(input1,28,28)';
images(:,:,2)=reshape(input2,28,28)';
images(:,:,3)=reshape(input3,28,28)';
images(:,:,4)=reshape(input4,28,28)';
images(:,:,5)=reshape(input5,28,28)';

sgtitle('Top 3 predictions');
hold on;
for i=1:5
    subplot(1,5,i)
    imshow(images(:,:,i));
    title({['Actual label = ',num2str(act(i))];['P(',num2str(ind(1,i)-1),') =',num2str(prob(1,i))];['P(',num2str(ind(2,i)-1),') =',num2str(prob(2,i))];['P(',num2str(ind(3,i)-1),') =',num2str(prob(3,i))]});
end

% for i=1:5
%     str = ['Image ',num2str(i),': Actual label = ',num2str(actual_label(i))]; 
%     disp(str);
%     disp('Top predictions:');
%     [ind(:,i)-1 prob(:,i)]    
%     disp('----------------------------------');
% end
% 
% imshow(reshape(input1,28,28)');figure;
% imshow(reshape(input2,28,28)');figure;
% imshow(reshape(input3,28,28)');figure;
% imshow(reshape(input4,28,28)');figure;
% imshow(reshape(input5,28,28)');

