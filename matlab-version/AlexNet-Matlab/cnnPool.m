function output_matrix = cnnPool( input_matrix,poolsize,stride )
%CNNPOOL �ػ�����
%   input_matrix:3-D����
%   poolsize:�������ڴ�С����ʽΪ[a,b]��aΪ����bΪ����
%   stride:������������ʽΪ[c,d],cΪ����dΪ����

[a,b,c] = size(input_matrix);
p_1 = poolsize(1);
p_2 = poolsize(2);
s_1 = stride(1);
s_2 = stride(2);
m = (a-p_1)/s_1+1;
n = (b-p_2)/s_2+1;
output_matrix = single(zeros(m,n,c));
for k = 1:c
    for i = 1:m
        for j = 1:n
            output_matrix(i,j,k) = max(max(input_matrix(...
                (1+(i-1)*s_1):(p_1+(i-1)*s_1),...
                (1+(j-1)*s_2):(p_2+(j-1)*s_2),...
                k)));
        end
    end
end
end

