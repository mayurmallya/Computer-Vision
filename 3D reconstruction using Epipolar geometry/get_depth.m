function depthM = get_depth(dispM, K1, K2, R1, R2, t1, t2)
% GET_DEPTH creates a depth map from a disparity map (DISPM).

c1 = -inv(K1*R1)*K1*t1;
c2 = -inv(K2*R2)*K2*t2;
b = sqrt(sum((c1-c2).^2));

f = K1(1,1);

depthM = dispM;
for i = 1:size(depthM,1)
    for j = 1:size(depthM,2)
        if depthM(i,j)~=0
            depthM(i,j) = b*f/dispM(i,j);
        end
    end    
end
