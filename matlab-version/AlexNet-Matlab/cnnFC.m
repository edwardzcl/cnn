function output = cnnFC( input, weight_matrix, bias )
%CNNFC 全连接层运算，实际上为矩阵乘法运算
%   input:一个1*n的向量，表示输入
%   weight_matrix:一个m*n的矩阵，表示权值
%   bias:一个1*n的向量，表示偏移
%   output:一个1*m的向量

[~,k] = size(input);
%输入向量转为1*n形式
if k~=1
    temp = weight_matrix*input(:);
else
    temp = weight_matrix*input;
end

output = temp + bias;
output = single(output);

end