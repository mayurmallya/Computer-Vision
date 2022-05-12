function [H2to1] = computeH_norm(x1, x2)

locs1 = x1;
locs2 = x2;

%% Compute centroids of the points
centroid1 = mean(locs1);
centroid2 = mean(locs2);

%% Shift the origin of the points to the centroid
locs1_new = locs1-centroid1;
locs2_new = locs2-centroid2;

%% Normalize the points so that the average distance from the origin is equal to sqrt(2).
num_points = size(locs1, 1);
avg_dist1 = sum(sqrt(sum(locs1_new.^2, 2)))/num_points;
locs1_norm = locs1_new * sqrt(2) / avg_dist1;
avg_dist2 = sum(sqrt(sum(locs2_new.^2, 2)))/num_points;
locs2_norm = locs2_new * sqrt(2) / avg_dist2;

%% similarity transform 1
T1 = [sqrt(2)/avg_dist1, 0, -1*sqrt(2)*centroid1(1)/avg_dist1;
      0, sqrt(2)/avg_dist1, -1*sqrt(2)*centroid1(2)/avg_dist1;
      0, 0, 1];
  
%% similarity transform 2
T2 = [sqrt(2)/avg_dist2, 0, -1*sqrt(2)*centroid2(1)/avg_dist2;
      0, sqrt(2)/avg_dist2, -1*sqrt(2)*centroid2(2)/avg_dist2;
      0, 0, 1]; 

%% Compute Homography
H2to1_norm = computeH(locs1_norm, locs2_norm);

%% Denormalization
H2to1 = inv(T1) * H2to1_norm * T2;

