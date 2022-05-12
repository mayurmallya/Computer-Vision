img1 = imread('./data/cv_cover.jpg');
img2 = imread('./data/cv_desk.png');

[locs1, locs2] = matchPics(img1, img2);
showMatchedFeatures(img1,img2,locs1,locs2,'montage');