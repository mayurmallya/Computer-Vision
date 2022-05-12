function [img1] = myImageFilter(img0, h)

[img0_rows, img0_cols] = size(img0);
img1 = zeros(size(img0));

%convolution is filtering with ulta kernel
h = rot90(h,2);

%padding
[h_rows, h_cols] = size(h);
img0 = padarray(img0, [(h_rows-1)/2, (h_cols-1)/2], 'replicate', 'pre');
img0 = padarray(img0, [(h_rows-1)/2, (h_cols-1)/2], 'replicate', 'post');

%convolution
for i = 1 : img0_rows
    for j = 1 : img0_cols
        img1(i,j) = sum(sum(double(img0(i:i+h_rows-1, j:j+h_cols-1)).* h)); 
    end
end

%disp(size(img1));
%intensity standardization
% max_pix0 = double(max(img0(:)));
% min_pix0 = double(min(img0(:)));
% max_pix1 = double(max(img1(:)));
% min_pix1 = double(min(img1(:)));
% img1 = uint8(((img1-min_pix1)*(max_pix0-min_pix0)/(max_pix1-min_pix1))+min_pix0);
%img1 = uint8((img1-min_pix1)*255/(max_pix1-min_pix1));
end
