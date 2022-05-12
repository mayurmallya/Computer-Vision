function [K, R, t] = estimate_params(P)
% ESTIMATE_PARAMS computes the intrinsic K, rotation R and translation t from
% given camera matrix P.

% Pc = 0
[~,~,v] = svd(P);
c = v(:,end);
c = c/c(end);
c = c(1:3);

% QR decomposition
M = P(:,1:3);
P_i = [0 0 1;0 1 0; 1 0 0];
M_dash = P_i * M;
[Q_dash, R_dash] = qr(M_dash');
Q = P_i * Q_dash';
R = P_i * R_dash' * P_i;

K = R;
R = Q;
t = -R*c;


