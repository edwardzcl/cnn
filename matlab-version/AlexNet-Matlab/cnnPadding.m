function output_matrix = cnnPadding( input_matrix,padding_vector )
%CNNPADDING 在矩阵的四周填充0
%   input_matrix:3-D矩阵
%   padding_vector:填充0数量，需要是[padding_vector_1,padding_vector_2]形式
%   其中padding_vector_1为竖向，padding_vector_2为横向

[a,b,c] = size(input_matrix);
d = padding_vector(1);
e = padding_vector(2);

output_matrix = [zeros(a,e,c),input_matrix,zeros(a,e,c)];
output_matrix = [zeros(d,b+2*e,c);output_matrix;zeros(d,b+2*e,c)];
output_matrix = single(output_matrix);
end

