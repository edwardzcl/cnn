clear;
clc;

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

%指定并读入图片
filename = 'Caltech101-ImageNetLabel/starfish/image_0010.jpg';
disp(filename);
I = imread(filename);
I = imresize(I,[227,227]);
if length(size(I)) == 3
    II = I;
else
    if length(size(I)) == 2
        II(:,:,1) = I;
        II(:,:,2) = I;
        II(:,:,3) = I;
    end
end

%减去图像均值，生成CNN输入特征图
image = single(II) - normalization.averageImage;
%带入AlexNet，得到输出分类序号
category = alexnet(image);
%在'alex_without_nor.mat'中的classes结构体中查找到输出结果
result = classes.name{category};