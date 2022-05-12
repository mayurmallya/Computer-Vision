function [dictionary] = getDictionary(imgPaths, alpha, K, method)

train_imagenames = imgPaths.train_imagenames;

pixelResponses = [];
filterbank = createFilterBank();

for i = 1:5%size(train_imagenames, 2)
    i_path = train_imagenames{1,i};
    img = imread(i_path);
    
    if length(size(img))==3
        filterResponses = extractFilterResponses(img, filterbank);
        
        if method == 'harris'
            k = 0.05;
            points = getHarrisPoints(img, alpha, k);
        else
            points = getRandomPoints(img, alpha);
        end
        
        i1 = repmat(points(:,2), 1, 60);
        i2 = repmat(points(:,1), 1, 60);
        i3 = repmat(1:60, alpha, 1);
        ind = sub2ind(size(filterResponses), i1, i2, i3);
        pixelResponses_img = filterResponses(ind);
        pixelResponses = [pixelResponses; pixelResponses_img];
    end    
end

[~, dictionary] = kmeans(pixelResponses, K, 'EmptyAction', 'drop');