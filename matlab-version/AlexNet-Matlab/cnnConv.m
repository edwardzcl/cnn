function output_matrix = cnnConv( input_matrix, filter_matrix, stride )
%CNNCONV 一个多通道特征图与多个多通道卷积核的多个3-D卷积操作
%   input_matrix:一个多通道特征图（即一个3-D矩阵）
%   filter_matrix:多个多通道卷积核（即多个同规模的3-D矩阵，亦即一个4-D矩阵）
%   filter_matrix中每个3-D矩阵的层数应与input_matrix一致
%   stride:卷积步长，表示为[stride_1,stride_2]

[row_a,col_a,~] = size(input_matrix);
[row_b,col_b,~,d] = size(filter_matrix);
s_1 = stride(1);
s_2 = stride(2);

%定义输出特征图
output_matrix = zeros((row_a - row_b)/s_1 + 1,(col_a - col_b)/s_2 + 1,d);

%计算每一个3-D卷积
for m = 1:d
    
    %卷积核一维化
    filter_matrix_temp = filter_matrix(:,:,:,m);
    filter_matrix_temp = filter_matrix_temp(:);
    [s_3,~] = size(filter_matrix_temp);
    for j = 1 : ((col_a - col_b)/s_2 + 1)
        for i = 1 : ((row_a - row_b)/s_1 + 1)
            
            %选取窗口矩阵并一维化
            temp = input_matrix((i*s_1+1-s_1):(i*s_1+row_b-s_1),(j*s_2+1-s_2):(j*s_2+col_b-s_2),:);
            temp_2 = temp(:);
            
            %算出点乘
            %这里分两段写是为了转fixed-point converter转定点数不报错，实际上完全可以合在一块
            temp_3 = filter_matrix_temp(1)*temp_2(1);
            for k = 2:s_3
                temp_3 = temp_3 + filter_matrix_temp(k)*temp_2(k);
            end
            
            output_matrix(i,j,m) = temp_3;
        end
    end
end

end

