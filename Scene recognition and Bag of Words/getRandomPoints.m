function [points] = getRandomPoints(I, alpha)

x = randi(size(I, 2), alpha, 1);
y = randi(size(I, 1), alpha, 1);

points = [x, y];


