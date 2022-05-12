function P = estimate_pose(x, X)
% ESTIMATE_POSE computes the pose matrix (camera matrix) P given 2D and 3D
% points.
%   Args:
%       x: 2D points with shape [2, N]
%       X: 3D points with shape [3, N]

% homogeneous
X(4,:)=1;

A = [];
for i = 1:size(X,2)
    x_pt = x(1,i);
    y_pt = x(2,i);
    X_pt = X(:,i);
    A = [A; X_pt' 0 0 0 0 -x_pt*X_pt'; 0 0 0 0 X_pt' -y_pt*X_pt'];
end

[~, ~, v] = svd(A);
P = v(:,end);
P = reshape(P, [4,3])';









