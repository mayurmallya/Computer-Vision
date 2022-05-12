clc
clear

% img = imread('./data/desert/sun_adpbjcrpyetqykvt.jpg');
% img = imread('./data/auditorium/sun_aajdmnyblbbdcuff.jpg');
% img = imread('./data/bedroom/sun_aarvhntgsdfxgmmb.jpg');
% img = imread('./data/airport/sun_afbqkfbmosznjtlq.jpg');
% img = imread('./data/campus/sun_abslhphpiejdjmpz.jpg');
% % imshow(img);
% img = imread('airport/sun_aflgtvhkyftqgkgx.jpg');
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% filterbank = createFilterBank();
% filterResponses = extractFilterResponses(img, filterbank);
% 
% %Display
% for k = 1:60
%     figure; imshow(filterResponses(:,:,k), []);
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% alpha = 500;
% points = getRandomPoints(img, alpha);
% imshow(img); hold on; plot(points(:,1), points(:,2), 'y.');
%
% %%%%%%%%%%%%%%%%%%%%%%
% 
% k = 0.05;
% alpha = 500;
% points = getHarrisPoints(img, alpha, k);
% figure;
% imshow(img); hold on; plot(points(:,1), points(:,2), 'r.', 'MarkerSize', 10);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% imgPaths = load('./data/traintest.mat');
% alpha = 50;
% K = 100; 
% method = 'harris';
% dictionary = getDictionary(imgPaths, alpha, K, method);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

filterbank = createFilterBank();
% wordMap = getVisualWords(I, filterBank, dictionary);






































