clc
clear

layers = get_lenet();
load lenet.mat
layers{1}.batch_size = 1;

act = [1 2 3 4 5 6 7 8 9 0];
img = imread('./images/image1.JPG');
img = im2double(rgb2gray(img));
img = 1-img;
img = ones(size(img)).* (0.5<img);
imshow(img);
CC = bwconncomp(img);
figure;
sgtitle('Top 3 predictions from Image 1');
hold on;
prediction1=[];
for i = 1:10
    ind = cell2mat(CC.PixelIdxList(i));
    [r,c] = ind2sub(size(img),ind);
    minr = min(r);
    maxr = max(r);
    minc = min(c);
    maxc = max(c);
    %corners = [minc minr; minc maxr; maxc minr; maxc maxr];
    img_cropped = img(minr:maxr, minc:maxc);
    img_input = padarray(img_cropped, [40,40], 0, 'both');
    img_input = imresize(img_input, [28,28]);
    subplot(2,5,i)
    imshow(img_input);
    img_input = img_input';
    input = reshape(img_input, 28*28,1);
    [~, P] = convnet_forward(params, layers, input);
    [prob,ind] = maxk(P,3);
    prediction1(i) = ind(1)-1;
    title({['Actual label = ',num2str(act(i))];['P(',num2str(ind(1)-1),') =',num2str(prob(1))];['P(',num2str(ind(2)-1),') =',num2str(prob(2))];['P(',num2str(ind(3)-1),') =',num2str(prob(3))]});
end
ncorrects1 = length(find(~(act-prediction1)));
disp(['Accuracy (image 1) = ',num2str(ncorrects1),'/10 = ',num2str(ncorrects1/10)]);
gt = act;

figure;
act = [1 2 3 4 5 6 7 8 9 0];
img = imread('./images/image2.JPG');
img = im2double(rgb2gray(img));
img = 1-img;
img = ones(size(img)).* (0.5<img);
imshow(img);
CC = bwconncomp(img);
figure;
sgtitle('Top 3 predictions from Image 2');
hold on;
prediction2=[];
for i = 1:10
    ind = cell2mat(CC.PixelIdxList(i));
    [r,c] = ind2sub(size(img),ind);
    minr = min(r);
    maxr = max(r);
    minc = min(c);
    maxc = max(c);
    %corners = [minc minr; minc maxr; maxc minr; maxc maxr];
    img_cropped = img(minr:maxr, minc:maxc);
    img_input = padarray(img_cropped, [40,40], 0, 'both');
    img_input = imresize(img_input, [28,28]);
    subplot(2,5,i)
    imshow(img_input);
    img_input = img_input';
    input = reshape(img_input, 28*28,1);
    [~, P] = convnet_forward(params, layers, input);
    [prob,ind] = maxk(P,3);
    prediction2(i)=ind(1)-1;
    title({['Actual label = ',num2str(act(i))];['P(',num2str(ind(1)-1),') =',num2str(prob(1))];['P(',num2str(ind(2)-1),') =',num2str(prob(2))];['P(',num2str(ind(3)-1),') =',num2str(prob(3))]});
end
ncorrects2 = length(find(~(act-prediction2)));
disp(['Accuracy (image 2) = ',num2str(ncorrects2),'/10 = ',num2str(ncorrects2/10)]);
gt = [act, act];

figure;
act = [6 0 6 2 6];
img = imread('./images/image3.png');
img = im2double(rgb2gray(img));
img = 1-img;
img = ones(size(img)).* (0.5<img);
imshow(img);
CC = bwconncomp(img);
figure;
sgtitle('Top 3 predictions from Image 3');
hold on;
prediction3=[];
for i = 1:5
    ind = cell2mat(CC.PixelIdxList(i));
    [r,c] = ind2sub(size(img),ind);
    minr = min(r);
    maxr = max(r);
    minc = min(c);
    maxc = max(c);
    %corners = [minc minr; minc maxr; maxc minr; maxc maxr];
    img_cropped = img(minr:maxr, minc:maxc);
    img_input = padarray(img_cropped, [30,30], mode(img_cropped(:)), 'both');
    img_input = imresize(img_input, [28,28]);
    subplot(1,5,i)
    imshow(img_input);
    img_input = img_input';
    input = reshape(img_input, 28*28,1);
    [~, P] = convnet_forward(params, layers, input);
    [prob,ind] = maxk(P,3);
    prediction3(i) = ind(1)-1;
    title({['Actual label = ',num2str(act(i))];['P(',num2str(ind(1)-1),') =',num2str(prob(1))];['P(',num2str(ind(2)-1),') =',num2str(prob(2))];['P(',num2str(ind(3)-1),') =',num2str(prob(3))]});
end
ncorrects3 = length(find(~(act-prediction3)));
disp(['Accuracy (image 3) = ',num2str(ncorrects3),'/5 = ',num2str(ncorrects3/5)]);
gt = [gt, act];

figure;
act = [7 0 3 9 1 2 6 7 6 1 3 9 6 4 1 4 2 0 0 5 4 4 7 3 1 0 2 5 5 1 7 7 4 9 1 7 4 9 2 1 5 3 4 0 2 9 4 4 1 1];
img = imread('./images/image4.jpg');
img = im2double(rgb2gray(img));
img = 1-img;
img = ones(size(img)).* (0.2<img);
imshow(img);
% img_conv = conv2(img, ones(2,2),'valid');
% img = ones(size(img)).* (0.15<img);
CC = bwconncomp(img);
figure;
sgtitle('Top 3 predictions from Image 4');
hold on;
prediction4=[];
j=1;
for i = 1:length(CC.PixelIdxList)
    if i == 46
        continue;
    end     
    ind = cell2mat(CC.PixelIdxList(i)); 
    [r,c] = ind2sub(size(img),ind);
    minr = min(r);
    maxr = max(r);
    minc = min(c);
    maxc = max(c);
    %corners = [minc minr; minc maxr; maxc minr; maxc maxr];
    img_cropped = img(minr:maxr, minc:maxc);
    img_input = padarray(img_cropped, [10,10], 0, 'both');
    img_input = imresize(img_input, [28,28]); 
        
    subplot(2,5,mod(j,10)+(~mod(j,10))*10)
    imshow(img_input);
    img_input = img_input';
    input = reshape(img_input, 28*28,1);
    [~, P] = convnet_forward(params, layers, input);
    [prob,ind] = maxk(P,3);
    prediction4(j) = ind(1)-1;
    title({['Actual label = ',num2str(act(j))];['P(',num2str(ind(1)-1),') =',num2str(prob(1))];['P(',num2str(ind(2)-1),') =',num2str(prob(2))];['P(',num2str(ind(3)-1),') =',num2str(prob(3))]});
    if mod(j,10)==0 && j~=50
        figure;
        sgtitle('Top 3 predictions from Image 4');
        hold on;
    end
    j=j+1;
end
ncorrects4 = length(find(~(act-prediction4)));
disp(['Accuracy (image 4) = ',num2str(ncorrects4),'/50 = ',num2str(ncorrects4/50)]);

totalcorrects = ncorrects1+ncorrects2+ncorrects3+ncorrects4;
overallaccuracy = totalcorrects/75;
disp(['Overall accuracy = ',num2str(totalcorrects),'/75 = ',num2str(overallaccuracy)]);

C = zeros(10,10);
gt = [gt, act];
pd = [prediction1, prediction2, prediction3, prediction4];
for k = 1:length(gt)
    gt_label = gt(k);
    pd_label = pd(k);
    C(gt_label+1, pd_label+1) = C(gt_label+1, pd_label+1) + 1;
end
C
% Old code


% act = [7 2 1 0 4 1 4 9 5 9 0 6 9 0 1 5 9 7 3 4 9 6 6 5 4 0 7 4 0 1 3 1 3 4 7 2 7 1 2 1 1 7 4 2 3 5 1 2 4 4];
% img = imread('./images/image4.jpg');
% img = 255-img; 
% img = im2double(rgb2gray(img)); 
% img = ones(size(img)).*(0.5<img); imshow(img);
% 
% act_ind = 1;
% for r = 0:4
%     count=1; figure;
%     for c = 0:9
%         if c<=4
%             img_cropped = img(r*41+1:(r+1)*41, c*25+1:(c+1)*25);
%             img_cropped = padarray(img_cropped,[3,3],0,'both');
%         else
%             img_cropped = img(r*41+1:(r+1)*41+1, c*25+7:(c+1)*25+1);
%             img_cropped = padarray(img_cropped,[5,5],0,'both');
%         end
%         img_new = imresize(img_cropped,[28,28]);
%         img_input = img_new';
%         input = reshape(img_input, 28*28,1);
%         [~, P] = convnet_forward(params, layers, input);
%         [prob,ind] = maxk(P,3);
%         subplot(2,5,count) 
%         imshow(img_new);
%         title({['Actual label = ',num2str(act(act_ind))];['P(',num2str(ind(1)-1),') =',num2str(prob(1))];['P(',num2str(ind(2)-1),') =',num2str(prob(2))];['P(',num2str(ind(3)-1),') =',num2str(prob(3))]});
%         count = count+1; act_ind = act_ind+1;
%     end
% end    