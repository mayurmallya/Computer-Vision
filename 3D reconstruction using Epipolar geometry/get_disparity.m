function dispM = get_disparity(im1, im2, maxDisp, windowSize)
% GET_DISPARITY creates a disparity map from a pair of rectified images im1 and
%   im2, given the maximum disparity MAXDISP and the window size WINDOWSIZE.

window_size = windowSize;
i1 = im1;
i2 = im2;

wing = (window_size-1)/2;
i1_pad = im2double(i1);
i2_pad = im2double(i2);
i1_pad = padarray(i1_pad, [wing,wing], 0, 'both');
i2_pad = padarray(i2_pad, [wing,wing], 0, 'both');

dispM = zeros(size(i1));

% y = 480; x = 400;
% imshow(i1); hold on; plot(x,y,'r*');
% y=480;

for y = 1:size(i1,1)

    for x=1:size(i1,2)
        
        x_pad = x + wing;
        row_pad = y + wing;
        
        i1_patch = i1_pad(row_pad-wing:row_pad+wing, x_pad-wing:x_pad+wing);
        %i1_patch

        min_distance = 100000;
        d = 0;
        
        for col_pad = max(wing+1,x_pad-maxDisp) : x_pad
    
            i2_patch = i2_pad(row_pad-wing:row_pad+wing, col_pad-wing:col_pad+wing);
            %i2_patch
            distance = sqrt(sum(sum((i1_patch-i2_patch).^2)));
            %distance = sum(sum(abs(i1_patch-i2_patch)));
            if distance <= min_distance
                %change=1
                min_distance = distance;
                d = x_pad-col_pad;
            end
            
        end
        
        %d
        dispM(y,x)=d;
    end
end    
% figure; imshow(i2); hold on; plot(x-d, y, 'b*');