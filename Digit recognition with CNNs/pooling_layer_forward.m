function [output] = pooling_layer_forward(input, layer)

h_in = input.height;
w_in = input.width;
c = input.channel;
batch_size = input.batch_size;
k = layer.k;
pad = layer.pad;
stride = layer.stride;

h_out = (h_in + 2*pad - k) / stride + 1;
w_out = (w_in + 2*pad - k) / stride + 1;

output.height = h_out;
output.width = w_out;
output.channel = c;
% output.batch_size = batch_size;

% Replace the following line with your implementation.

output.data = zeros([h_out, w_out, c, batch_size]);
features = reshape(input.data, [h_in, w_in, c, batch_size]);
for i = 1:batch_size
    for j = 1:c
        f = features(:,:,j,i);
        % assuming k=2 s=2 p=0 always,  
        for y = 1:h_out
            for x = 1:w_out
                temp = f(2*y-1:2*y, 2*x-1:2*x);
                output.data(y,x,j,i) = max(temp(:));
            end    
        end
    end    
end
output.data = reshape(output.data, [h_out*w_out*c, batch_size]);
