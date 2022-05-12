function [input_od] = relu_backward(output, input, layer)

% Replace the following line with your implementation.
% input_od = zeros(size(input.data));

% output.diff has dL/dh_i
% and we need to calculate input_od which is dL/dh_i-1
% implies input_od is output.diff . * dh_i/dh_i-1 (chain rule)

input_od = output.diff .* (ones(size(input.data)) .* (0<input.data));

end
