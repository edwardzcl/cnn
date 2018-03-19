function output_vector = cnnSoftmax( input_vector )
%CNNSOFTMAX 此处显示有关此函数的摘要
%   此处显示详细说明
[n,~] = size(input_vector);
temp = zeros(size(input_vector));
total = 0;
for i = 1:n
    temp(i) = exp(input_vector(i));
    total = total + temp(i);
end
output_vector = temp/total;
end

