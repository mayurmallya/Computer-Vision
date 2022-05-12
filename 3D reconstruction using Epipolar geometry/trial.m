clc
clear

%   LOADING THE DATA
img1 = imread('./data/im1.png');
img2 = imread('./data/im2.png');
s = load('./data/someCorresp.mat');
M = s.M;
pts1 = s.pts1;
pts2 = s.pts2;
intrinsics = load('./data/intrinsics.mat');
K1 = intrinsics.K1;
K2 = intrinsics.K2;

%   FUNDAMENTAL MATRIX
F = eightpoint(pts1, pts2, M);
% format long;
% disp(F);
%displayEpipolarF(img1, img2, F);

%  EPIPOLAR MATCHING
pts2_new = epipolarCorrespondence(img1, img2, F, pts1);
%epipolarMatchGUI(img1, img2, F);

%   ESSENTIAL MATRIX
E = essentialMatrix(F, K1, K2);

%  3D PROJECTION
int1 = K1;
ext1 = [1 0 0 0; 0 1 0 0; 0 0 1 0];
P1 = int1 * ext1;
int2 = K2;
ext2_choices = camera2(E);
ext2_1 = ext2_choices(:,:,1); P2_1 = int2 * ext2_1;
ext2_2 = ext2_choices(:,:,2); P2_2 = int2 * ext2_2;
ext2_3 = ext2_choices(:,:,3); P2_3 = int2 * ext2_3;
ext2_4 = ext2_choices(:,:,4); P2_4 = int2 * ext2_4;
% tried all 4 projection matrices and clearly we need P2_2 since all ...
% ... z from the calculated pts3d are positive
P2 = P2_2;
pts3d = triangulate(P1, pts1, P2, pts2);

%  REPROJECTION ERROR
pts3d(:,4)=1;
pts1_2d = zeros(size(pts1,1),2);
for i = 1:size(pts1,1)
    p = P1 * pts3d(i,:)';
    p_het = p/p(3);
    pts1_2d(i,:) = p_het(1:2)';
end
reprojection_error_pts1 = sum(sum((pts1_2d-pts1).^2))/size(pts1,1)
pts2_2d = zeros(size(pts2,1),2);
for i = 1:size(pts2,1)
    p = P2 * pts3d(i,:)';
    p_het = p/p(3);
    pts2_2d(i,:) = p_het(1:2)';
end
reprojection_error_pts2 = sum(sum((pts2_2d-pts2).^2))/size(pts2,1)


plot3(pts3d(:,1), pts3d(:,2), pts3d(:,3),'.');
xlabel('x'); ylabel('y'); zlabel('z');

tc = load('./data/templeCoords.mat');
tc_pts1 = tc.pts1;
tc_pts2 = epipolarCorrespondence(img1, img2, F, tc_pts1);






