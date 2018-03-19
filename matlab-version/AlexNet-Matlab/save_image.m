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

%定义两个计数变量
count_total = 0;
correct_total = 0;
correct = zeros(size(label_name));
correct_rate = zeros(size(label_name));

fid=fopen('image.txt','w+');

for i = 1:size(label_name)
    %选取label_name数组中有的文件夹名
    dirstruct = dir(['Caltech101-ImageNetLabel\',label_name{i}]);
    [D,~] = size(dirstruct);
    n = D-2;
    for j = 1:n
        
        %每个文件夹中遍历所有图片并显示文件路径和文件名
        filename = ['Caltech101-ImageNetLabel/',label_name{i},'/',dirstruct(j+2,1).name];
        disp(filename);
        
        %读入图像，转图像为227*227大小
        I = imread(filename);
               % I(300,97:120,1)
               % I(300,97:120,2)
               % I(300,97:120,3)

        I = imresize(I,[227,227]);
                    %I(227,:,1)   
                    % I(227,:,2)
                    % I(227,:,3)
        if length(size(I)) == 3
            II = I;
        else
            %若为灰度图，则转化为RGB图
            if length(size(I)) == 2
                II(:,:,1) = I;
                II(:,:,2) = I;
                II(:,:,3) = I;
            end
        end
        
        %减去图像均值，生成CNN输入特征图
        image = single(II) - normalization.averageImage;
        
        for k=1:3
            for m = 1:227
                for n=1:227
                    count1=fprintf(fid,'%5.8f\n',image(m,n,k));
                end
            end
        end
    end
end
        fclose(fid);  
             

