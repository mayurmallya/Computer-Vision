% A test script using templeCoords.mat
% Write your code here

clc
clear

%   LOADING THE DATA
img1 = imread('./data/im1.png');
img2 = imread('./data/im2.png');
s = load('./data/someCorresp.mat');
M = s.M;
pts1 = s.pts1;
pts2 = s.pts2;

%   FUNDAMENTAL MATRIX
F = eightpoint(pts1, pts2, M);
%format long;
%disp(F);
%displayEpipolarF(img1, img2, F);

%   EPIPOLAR MATCHING
tc = load('./data/templeCoords.mat');
tc_pts1 = tc.pts1;
tc_pts2 = epipolarCorrespondence(img1, img2, F, tc_pts1);
%epipolarMatchGUI(img1, img2, F);

%   ESSENTIAL MATRIX
intrinsics = load('./data/intrinsics.mat');
K1 = intrinsics.K1;
K2 = intrinsics.K2;
E = essentialMatrix(F, K1, K2);

%   PROJECTION MATRICES
int1 = K1;
ext1 = [1 0 0 0; 0 1 0 0; 0 0 1 0];
P1 = int1 * ext1;
int2 = K2;
ext2_choices = camera2(E);
ext2_1 = ext2_choices(:,:,1); P2_1 = int2 * ext2_1;
ext2_2 = ext2_choices(:,:,2); P2_2 = int2 * ext2_2;
ext2_3 = ext2_choices(:,:,3); P2_3 = int2 * ext2_3;
ext2_4 = ext2_choices(:,:,4); P2_4 = int2 * ext2_4;

%   TRIANGULATION
pts3d_1 = triangulate(P1, tc_pts1, P2_1, tc_pts2);
pts3d_2 = triangulate(P1, tc_pts1, P2_2, tc_pts2);
pts3d_3 = triangulate(P1, tc_pts1, P2_3, tc_pts2);
pts3d_4 = triangulate(P1, tc_pts1, P2_4, tc_pts2);
n1 = sum(0<pts3d_1(:,3));
n2 = sum(0<pts3d_2(:,3));
n3 = sum(0<pts3d_3(:,3));
n4 = sum(0<pts3d_4(:,3));
pts3d_final = pts3d_2; %after checking which has max number of positive z

%    3D MODEL FROM 2 2D IMAGES
plot3(pts3d_final(:,1), pts3d_final(:,2), pts3d_final(:,3),'o');
xlabel('x'); ylabel('y'); zlabel('z'); grid on;


% save extrinsic parameters for dense reconstruction
R1 = ext1(:,1:3);
t1 = ext1(:,4);
R2 = ext2_2(:,1:3);
t2 = ext2_2(:,4);
save('./data/extrinsics.mat', 'R1', 't1', 'R2', 't2');
