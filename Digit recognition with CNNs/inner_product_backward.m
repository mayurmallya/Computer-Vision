function [param_grad, input_od] = inner_product_backward(output, input, layer, param)

param_w = param.w';

% Replace the following lines with your implementation.
param_grad.b = zeros(size(param.b)); 
param_grad_w = zeros(size(param_w)); 
input_od = zeros(size(input.data));

h_in = input.height*input.width*input.channel;
% w_in = 1; % assumed
% c = 1; % assumed
batch_size = input.batch_size;
% inputs = reshape(input.data, [h_in, batch_size]);

h_out = output.height;
% w_out = 1; % assumed
% outputs = reshape(output.data, [h_out, batch_size]);

num = layer.num; % useless

for i = 1:batch_size
    temp = input.data(:,i);
    param_grad_w = param_grad_w + repmat(output.diff(:,i),1,h_in) .* repmat(temp',h_out,1);
    param_grad.b = param_grad.b + output.diff(:,i)' .* ones(1, h_out);
    temp1 = repmat(output.diff(:,i),1,h_in) .* param_w;
    temp2 = sum(temp1);
    input_od(:,i) = temp2';
end
param_grad.w = param_grad_w';
end
