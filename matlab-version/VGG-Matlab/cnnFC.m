function output = cnnFC( input, weight_matrix, bias )
%CNNFC ȫ���Ӳ����㣬ʵ����Ϊ����˷�����
%   input:һ��1*n����������ʾ����
%   weight_matrix:һ��m*n�ľ��󣬱�ʾȨֵ
%   bias:һ��1*n����������ʾƫ��
%   output:һ��1*m������

[~,k] = size(input);
%��������תΪ1*n��ʽ
if k~=1
    temp = weight_matrix*input(:);
else
    temp = weight_matrix*input;
end

output = temp + bias;
output = single(output);

end