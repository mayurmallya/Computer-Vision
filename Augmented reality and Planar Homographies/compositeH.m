function [ composite_img ] = compositeH( H2to1, template, img )
%COMPOSITE Create a composite image after warping the template image on top
%of the image using the homography

% Note that the homography we compute is from the image to the template;
% x_template = H2to1*x_photo
% For warping the template to the image, we need to invert it.
% H_template_to_img = inv(H2to1);

% Create mask of same size as template
mask = 255*ones(size(template));

% Warp mask by appropriate homography
wm = warpH(mask, H2to1, size(img), 0);
%figure; imshow(wm);

% Warp template by appropriate homography
wt = warpH(template, H2to1, size(img), 0);
%figure; imshow(wt);

% Use mask to combine the warped template and the image
img_new = double(uint8(double(img) + double(wm)));
%imshow(uint8(img_new));

for i = 1:size(img_new,1)
    for j = 1:size(img_new,2)
        if sum(img_new(i,j,:))==255*3
            img_new(i,j,:)=wt(i,j,:);
        end
    end
end
composite_img = img_new;
end