% Network defintion
layers = get_lenet();

% Loading data
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);

% load the trained weights
load lenet.mat

% Testing the network
% Modify the code to get the confusion matrix
C = zeros(10,10);
j=1;
for i=1:100:size(xtest, 2)
    [output, P] = convnet_forward(params, layers, xtest(:, i:i+99));
    for k = 1:100
        gt_label = ytest(j);
        j = j+1;
        [~,p_label] = max(P(:,k));
        C(gt_label, p_label) = C(gt_label, p_label) + 1;    
    end
end

C