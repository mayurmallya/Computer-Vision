function F = eightpoint(pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'

% Normalizing points
pts1_norm = pts1/M;
pts2_norm = pts2/M;
n = size(pts1, 1);

% Creating matrix A of AF=0
A = zeros(n, 9);
for i = 1 : n
    x = pts1_norm(i, 1); 
    y = pts1_norm(i, 2);
    x_dash = pts2_norm(i, 1); 
    y_dash = pts2_norm(i, 2);
    A(i, :) = [x_dash*x, x_dash*y, x_dash, y_dash*x, y_dash*y, y_dash, x, y, 1];
end

% Finding SVD of A
[~,~,v] = svd(A);
F_column = v(:,end);
F = reshape(F_column, [3,3]).';

% Enforcing rank 2 constraint on F
[u, s, v] = svd(F);
s(end,end) = 0;
s_new = s;
F_new = u *s_new * v';

% Refining F_new
F_refined = refineF(F_new, pts1_norm, pts2_norm);

% Un-normalizing F_refined
denorm_matrix = [1/M^2, 1/M^2, 1/M; 1/M^2, 1/M^2, 1/M; 1/M, 1/M, 1];
F = F_refined.*denorm_matrix;
