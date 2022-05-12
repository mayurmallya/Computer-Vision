function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.
%Q2.2.3

n = size(locs1, 1);

error_threshold = 1;
iter = 1000;

max_inliers_count = 0;
bestH2to1 = zeros(3,3);
change = 0;

for j=1:iter
    index = randperm(n, 4);
    locs1_p4 = locs1(index, :);
    locs2_p4 = locs2(index, :);
    H2to1 = computeH_norm(locs1_p4, locs2_p4);
    locs1_pred = zeros(size(locs1, 1), size(locs1, 2)+1);
    P2 = locs2;
    P2(:,3) = ones(n,1);
    for i = 1:n
        locs1_pred(i,:) = H2to1 * P2(i, :)';
        locs1_pred(i,:) = locs1_pred(i,:)/locs1_pred(i,3);
    end
    locs1_pred = locs1_pred(:,1:2);
    error = abs(locs1-locs1_pred);
    inliers = error < error_threshold;
    new_inliers = inliers(:,1) & inliers(:,2);
    inliers_count = sum(new_inliers);
    if max_inliers_count<inliers_count
        max_inliers_count = inliers_count;
        bestH2to1 = H2to1;
        best_inliers = new_inliers;
        change = change +1;
    end
end
inliers = best_inliers;
end

