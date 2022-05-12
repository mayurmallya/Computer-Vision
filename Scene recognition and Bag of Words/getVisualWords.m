function [wordMap] = getVisualWords(I, filterBank, dictionary)

if length(size(I))==3
    dictionary = dictionary';
    filterResponses = extractFilterResponses(I, filterBank);
    fr = reshape(filterResponses, size(filterResponses,1)*size(filterResponses,2), 60);
    d = pdist2(fr, dictionary);
    [~, ind] = min(d, [], 2);
    wordMap = reshape(ind, size(filterResponses,1), size(filterResponses,2));
else
    wordMap = ones(size(I));
end