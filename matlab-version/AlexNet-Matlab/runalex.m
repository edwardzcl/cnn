clear;
clc;

%读入label数据
%在这里，label_ss.mat有18个分类，label_s.mat有47个分类，label.mat有58个分类
load label_ss.mat;

%读入模型文件：imagenet-caffe-alex.mat，即原始模型文件
%convnet = helperImportMatConvNet('imagenet-caffe-alex.mat');
%load ('imagenet-caffe-alex.mat');

%读入模型文件：alex_without_nor.mat,其被人为去除Normalization层
convnet = helperImportMatConvNet('alex_without_nor.mat');
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

%遍历图像，识别图像，计数
for i = 1:size(label_name)
    %选取label_name数组中有的文件夹名
    dirstruct = dir(['Caltech101-ImageNetLabel/',label_name{i}]);
    [D,~] = size(dirstruct);
    n = D-2;
    for j = 1:n
        
        %每个文件夹中遍历所有图片并显示文件路径和文件名
        filename = ['Caltech101-ImageNetLabel/',label_name{i},'/',dirstruct(j+2,1).name];
        disp(filename);
        
        %读入图像，转图像为227*227大小
        tic;%计时开始
        I = imread(filename);
        I = imresize(I,[227,227]);
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
        
        % category = activations(convnet,II,'classificationLayer');
        % [~,idx] = max(category);
        % result = convnet.Layers(end).ClassNames{idx};
        
        %激活最后一个分类Layer
        category = activations(convnet,II,'fc8');
        %找到概率最大的类
        [~,idx] = max(category);
        %在'alex_without_nor.mat'中的classes结构体中查找到输出结果
        result = classes.name{idx};
        
        %判断result是否包含在该文件夹所对应的label编号列表中
        for k = 1:5
            if strcmp(label{i,k},result)
                correct_total = correct_total + 1;
                correct(i) = correct(i) + 1;
            end
        end
        
        count_total = count_total + 1;
        toc;%计时结束
    end
    correct_rate(i) = correct(i)/n;
end

%计算准确率
correct_rate_total = correct_total/count_total;

save('runalex_result.mat','correct_rate','correct_rate_total','correct_total','count_total');