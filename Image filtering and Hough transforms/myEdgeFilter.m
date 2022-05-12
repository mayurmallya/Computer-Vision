function [img1] = myEdgeFilter(img0, sigma)

% smoothing the input image
hsize = 2*ceil(3*sigma)+1;
h = fspecial('gaussian',hsize,sigma);
img0_smoothed = myImageFilter(img0, h);

% calculating image gradients- magnitude and angle
sobel_x = [1 0 -1; 2 0 -2; 1 0 -1];
sobel_y = [1 2 1; 0 0 0; -1 -2 -1];
img0_grad_x = myImageFilter(img0_smoothed, sobel_x);
img0_grad_y = myImageFilter(img0_smoothed, sobel_y);
img0_grad_abs = sqrt((double(img0_grad_x)).^2 + (double(img0_grad_y)).^2);
img0_grad_angle = atand(double(img0_grad_y)./double(img0_grad_x)) * 180/pi;
%img0_grad_angle = atan2d(double(img0_grad_y), double(img0_grad_x));

% NMS

img0_grad_abs = padarray(img0_grad_abs, [1, 1]);
img0_grad_angle = padarray(img0_grad_angle, [1, 1]);
[img0_rows, img0_cols] = size(img0_grad_abs);
img1 = img0_grad_abs;

for i = 2 : img0_rows-1
    for j = 2 : img0_cols-1
        angle = img0_grad_angle(i,j);
        if angle <= -22.5  % -45
            if (img0_grad_abs(i,j) <= max(img0_grad_abs(i-1,j-1), img0_grad_abs(i+1,j+1)))
                img1(i,j) = 0;
            end
        elseif angle <= 22.5  % 0
            if (img0_grad_abs(i,j) <= max(img0_grad_abs(i,j-1), img0_grad_abs(i,j+1)))
                img1(i,j) = 0;
            end
        elseif angle <= 67.5  % 45
            if (img0_grad_abs(i,j) <= max(img0_grad_abs(i-1,j+1), img0_grad_abs(i+1,j-1)))
                img1(i,j) = 0;
            end
        else  % 90
            if (img0_grad_abs(i,j) <= max(img0_grad_abs(i-1,j), img0_grad_abs(i+1,j)))
                img1(i,j) = 0;
            end            
        end
    end
end   
img1(1,:) = [];
img1(img0_rows-1, :) = [];
img1(:,1) = [];
img1(:, img0_cols-1) = [];
img1 = uint8(img1);
end
    
                
        
        
