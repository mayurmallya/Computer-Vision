function [ H2to1 ] = computeH(x1,x2)
%COMPUTEH Computes the homography between two sets of points
locs1 = x1; locs2 = x2;
num_points = 10;
index = randperm(size(locs1,1), num_points);

A = zeros(2*num_points, 9);

i=1;
for j = 1 : num_points
    x = locs2(index(j),1); 
    y = locs2(index(j),2);
    x_dash = locs1(index(j),1); 
    y_dash = locs1(index(j),2);
    A(i, :) = [-x -y -1 0 0 0 x*x_dash y*x_dash x_dash];
    A(i+1, :) = [0 0 0 -x -y -1 x*y_dash y*y_dash y_dash];
    i = i + 2;
end

[~, ~, V] = svd(A);
h = V(:, 9);
H2to1 = reshape(h,[3,3]).';

end
