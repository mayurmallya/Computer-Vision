function [rhos, thetas] = myHoughLines(H, nLines)

% NMS kernel
k_size = 15;
%kernel = ones(k_size,k_size);
scale = (k_size-1)/2;

H = padarray(H, [scale, scale]);
NMS_H = H;
[H_row, H_col] = size(H);

% NMS
for i = scale+1 : H_row-scale
    for j = scale+1 : H_col-scale
        conv = H(i-scale:i+scale, j-scale:j+scale);
        if conv(scale+1,scale+1) < max(conv(:))
            NMS_H(i,j) = 0;
        end    
    end
end
NMS_H = NMS_H(scale+1:end-scale, scale+1:end-scale);
%SH = size(NMS_H);

% collecting high intensity points coordinates
NMS_H_copy = NMS_H;
row = zeros(1, nLines);
col = zeros(1, nLines);
i=1;count=0;
while count < nLines
    [r,c] = find(NMS_H == max(max(NMS_H)));
    f = length(r);
    NMS_H(r,c) = 0;
    for k = 1 : f
        row(i) = r(k);
        col(i) = c(k);
        i = i+1;
    end
    count = count + f;
end

rhos = row;
thetas = col;

end
        