function [ h ] = getImageFeatures(wordMap, dictionarySize)

h = zeros(1, dictionarySize);
wm = reshape(wordMap, 1, []);

for i = 1:dictionarySize
    h(i) = length(find(wm==i));
end

h = h/sum(h);
