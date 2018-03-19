clear;
clc;

load parameters.mat;

%读入label数据
%在这里，label_ss.mat有18个分类，label_s.mat有47个分类，label.mat有58个分类
load label_ss.mat;

%读入模型文件：imagenet-caffe-alex.mat，即原始模型文件
%convnet = helperImportMatConvNet('imagenet-caffe-alex.mat');
%load ('imagenet-caffe-alex.mat');

%读入模型文件：alex_without_nor.mat,其被人为去除Normalization层
%convnet = helperImportMatConvNet('alex_without_nor.mat');
load ('alex_without_nor.mat');

%读入模型文件：alex_without_nor_sm.mat,其被人为去除Normalization层和最后的softmax层
%convnet = helperImportMatConvNet('alex_without_nor_sm.mat');
%load ('alex_without_nor_sm.mat');

%读入模型文件：alex_without_sm.mat,其被人为去除最后的softmax层,保留Normalization层
%convnet = helperImportMatConvNet('alex_without_sm.mat');
%load ('alex_without_sm.mat');
for i=1:8
    switch i
        case 1
           weight{i}=weight_1;
        case 2
           weight{i}=weight_2;
        case 3
           weight{i}=weight_3;
        case 4
           weight{i}=weight_4;
        case 5
           weight{i}=weight_5;
        case 6
           weight{i}=weight_6;
        case 7
           weight{i}=weight_7;
        case 8
           weight{i}=weight_8;
    end
end

for i=1:8
    filter_matrix_temp = weight{i};
    filter_matrix_temp = filter_matrix_temp(:);
    [num,~] = size(filter_matrix_temp)
    maximum=max(filter_matrix_temp)
    minimum=min(filter_matrix_temp)
    [n,y]=hist(filter_matrix_temp);
    %figure;
    subplot(2,4,i);
    bar(y,n);
   for j = 1:length(y)
   text(double(y(j)),n(j)+10000,num2str(n(j)));
   end
end


