function [dist] = getImageDistance(hist1, histSet, method)

if strcmp(method,'euclidean')
    
    dist = sqrt(sum((histSet-hist1).^2, 2)); 
    
else
    
    hist1(hist1==0) = 0.0001; % trick to avoid NaN values
    histSet(histSet==0) = 0.0001;
    dist = 0.5*sum((((histSet-hist1).^2)./(histSet+hist1)), 2);

end