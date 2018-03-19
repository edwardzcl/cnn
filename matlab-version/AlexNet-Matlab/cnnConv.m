function output_matrix = cnnConv( input_matrix, filter_matrix, stride )
%CNNCONV һ����ͨ������ͼ������ͨ������˵Ķ��3-D�������
%   input_matrix:һ����ͨ������ͼ����һ��3-D����
%   filter_matrix:�����ͨ������ˣ������ͬ��ģ��3-D�����༴һ��4-D����
%   filter_matrix��ÿ��3-D����Ĳ���Ӧ��input_matrixһ��
%   stride:�����������ʾΪ[stride_1,stride_2]

[row_a,col_a,~] = size(input_matrix);
[row_b,col_b,~,d] = size(filter_matrix);
s_1 = stride(1);
s_2 = stride(2);

%�����������ͼ
output_matrix = zeros((row_a - row_b)/s_1 + 1,(col_a - col_b)/s_2 + 1,d);

%����ÿһ��3-D���
for m = 1:d
    
    %�����һά��
    filter_matrix_temp = filter_matrix(:,:,:,m);
    filter_matrix_temp = filter_matrix_temp(:);
    [s_3,~] = size(filter_matrix_temp);
    for j = 1 : ((col_a - col_b)/s_2 + 1)
        for i = 1 : ((row_a - row_b)/s_1 + 1)
            
            %ѡȡ���ھ���һά��
            temp = input_matrix((i*s_1+1-s_1):(i*s_1+row_b-s_1),(j*s_2+1-s_2):(j*s_2+col_b-s_2),:);
            temp_2 = temp(:);
            
            %������
            %���������д��Ϊ��תfixed-point converterת������������ʵ������ȫ���Ժ���һ��
            temp_3 = filter_matrix_temp(1)*temp_2(1);
            for k = 2:s_3
                temp_3 = temp_3 + filter_matrix_temp(k)*temp_2(k);
            end
            
            output_matrix(i,j,m) = temp_3;
        end
    end
end

end

