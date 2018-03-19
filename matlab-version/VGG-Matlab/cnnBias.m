function output_matrix = cnnBias( input_matrix, bias)
%CNNBIAS һ������������һ��ƫ��
%   input_matrix��һ��3-D����
%   bias��һ��һά����
%   ������Ϊÿ��2-D������϶�Ӧλ�õ�����ֵ

output_matrix = single(zeros(size(input_matrix)));
[~,~,n] = size(input_matrix);

for i = 1:n
    output_matrix(:,:,i) = input_matrix(:,:,i) + bias(i);
end

end

