function output_matrix = cnnPadding( input_matrix,padding_vector )
%CNNPADDING �ھ�����������0
%   input_matrix:3-D����
%   padding_vector:���0��������Ҫ��[padding_vector_1,padding_vector_2]��ʽ
%   ����padding_vector_1Ϊ����padding_vector_2Ϊ����

[a,b,c] = size(input_matrix);
d = padding_vector(1);
e = padding_vector(2);

output_matrix = [zeros(a,e,c),input_matrix,zeros(a,e,c)];
output_matrix = [zeros(d,b+2*e,c);output_matrix;zeros(d,b+2*e,c)];
output_matrix = single(output_matrix);
end

