function [output] = conv_layer_forward(input, layer, param)
% Conv layer forward
% input: struct with input data
% layer: convolution layer struct
% param: weights for the convolution layer

% output: 

h_in = input.height;
w_in = input.width;
c = input.channel;
batch_size = input.batch_size;

k = layer.k;
pad = layer.pad;
stride = layer.stride;
num = layer.num;

% resolve output shape
h_out = (h_in + 2*pad - k) / stride + 1;
w_out = (w_in + 2*pad - k) / stride + 1;

assert(h_out == floor(h_out), 'h_out is not integer')
assert(w_out == floor(w_out), 'w_out is not integer')
input_n.height = h_in;
input_n.width = w_in;
input_n.channel = c;

filters = reshape(param.w, [k,k,c,num]);
bias = param.b;

% Fill in the code
% Iterate over the each image in the batch, compute response,

output.data = zeros([h_out, w_out, num, batch_size]);
features = reshape(input.data, [h_in, w_in, c, batch_size]);
features = padarray(features, [pad,pad], 0, 'both');

for i = 1:batch_size
    f = features(:,:,:,i);
    for fr = 1:num
        for y = 1:h_out
            for x = 1:w_out
                % assuming s=1
                temp = f(y:y+4, x:x+4, :);
                prod = temp.*filters(:,:,:,fr);
                output.data(y,x,fr,i) = sum(prod(:)) + bias(fr);
            end    
        end
    end
end
output.data = reshape(output.data, [h_out*w_out*num, batch_size]);

% Fill in the output datastructure with data, and the shape. 
output.height = h_out;
output.width = w_out;
output.channel = num;
% output.batch_size = batch_size;

end

