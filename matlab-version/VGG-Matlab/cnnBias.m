function output_matrix = cnnBias( input_matrix, bias)
%CNNBIAS 一个输入矩阵加上一个偏移
%   input_matrix：一个3-D矩阵
%   bias：一个一维向量
%   计算结果为每个2-D矩阵加上对应位置的向量值

output_matrix = single(zeros(size(input_matrix)));
[~,~,n] = size(input_matrix);

for i = 1:n
    output_matrix(:,:,i) = input_matrix(:,:,i) + bias(i);
end

end

