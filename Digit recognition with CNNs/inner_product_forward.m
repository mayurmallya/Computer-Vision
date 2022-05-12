function [output] = inner_product_forward(input, layer, param)

d = size(input.data, 1);
k = size(input.data, 2); % batch size
n = size(param.w, 2);

% Replace the following line with your implementation.
% output.data = zeros([n, k]);


for i = 1:k
    output.data(:,i) = param.w * input.data(:,i) + param.b';
end
    
output.height = size(output.data,1);
output.width = 1;
output.channel = 1;
% output.batch_size = k;
end
