function output_vector = cnnSoftmax( input_vector )
%CNNSOFTMAX �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
[n,~] = size(input_vector);
temp = zeros(size(input_vector));
total = 0;
for i = 1:n
    temp(i) = exp(input_vector(i));
    total = total + temp(i);
end
output_vector = temp/total;
end

