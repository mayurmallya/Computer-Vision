% Q3.3.1
clc
clear

kfp = loadVid('./data/ar_source.mov');
book = loadVid('./data/book.mov');
book_img = imread('./data/cv_cover.jpg');

count=0;

v = VideoWriter('ar.avi');
v.FrameRate = 24;
open(v);

%loop
for i=1:511 %641
    book_frame = book(i).cdata;
    kfp_frame = kfp(i).cdata;
    
    % Extract features and match
    [locs1, locs2] = matchPics(book_frame, book_img);
    % Compute homography using RANSAC
    [bestH2to1, ~] = computeH_ransac(locs1, locs2);
    
    scaled_kfp_frame = imresize(kfp_frame, [600 640]);
    final_kfp_frame = scaled_kfp_frame(80:519, 145:494, :);
    
    composite_img = compositeH(bestH2to1, final_kfp_frame, book_frame);
    
    count=count+1
    %figure; imshow(uint8(composite_img));
    writeVideo(v, uint8(composite_img));
end    
close(v);