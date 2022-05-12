function [filterResponses] = extractFilterResponses(I, filterBank)

I=im2double(I);
I=I/255;
if length(size(I))==3
    newimg = RGB2Lab(I);
    newimg = im2double(newimg);
    % newimg(100,100)
else
    gray_image_alert = 1
end

% Why is the CIELab format better than RGB ???
% newimg = I;
% To see the advantages of CIELab format
% imshow(newimg);


n = size(filterBank, 1);
filterResponses = zeros(size(newimg,1), size(newimg,2), 3*n);


for j = 1:n
    for i = 1:3
        filterResponses(:,:,3*(j-1)+i) = conv2(newimg(:,:,i), cell2mat(filterBank(j)), 'same');
    end
end

filterResponses = 255 * filterResponses;