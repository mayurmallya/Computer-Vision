function [H, rhoScale, thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes)

Im = double(Im);
img = Im.*(threshold < Im);

index = find(img);
[y,x] = ind2sub(size(img), index);
total_points = length(y);

thetaScale = 0 : thetaRes : 2*pi;

rho = x.*cos(thetaScale) + y.*sin(thetaScale);
rho_approx = rho.*(0<rho);
rho_approx = round(rho_approx/rhoRes) * rhoRes;
rho_max = max(max(rho_approx));
H = zeros((rho_max/rhoRes)+1, length(thetaScale));

for i = 1 : total_points
    for j = 1: length(thetaScale)
        k = rho_approx(i,j);
        H(k/rhoRes +1, j) = H(k/rhoRes+1, j) + 1;
    end
end
H(1,:) = [];
rhoScale = min(min(rho_approx))+1 : rhoRes : max(max(rho_approx));
end
        
        