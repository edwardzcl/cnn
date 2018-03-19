clear;
clc;

%����label����
%�����label_ss.mat��18�����࣬label_s.mat��47�����࣬label.mat��58������
load label_ss.mat;

%����ģ���ļ���imagenet-caffe-alex.mat����ԭʼģ���ļ�
%convnet = helperImportMatConvNet('imagenet-caffe-alex.mat');
%load ('imagenet-caffe-alex.mat');

%����ģ���ļ���alex_without_nor.mat,�䱻��Ϊȥ��Normalization��
convnet = helperImportMatConvNet('alex_without_nor.mat');
load ('alex_without_nor.mat');

%����ģ���ļ���alex_without_nor_sm.mat,�䱻��Ϊȥ��Normalization�������softmax��
%convnet = helperImportMatConvNet('alex_without_nor_sm.mat');
%load ('alex_without_nor_sm.mat');

%����ģ���ļ���alex_without_sm.mat,�䱻��Ϊȥ������softmax��,����Normalization��
%convnet = helperImportMatConvNet('alex_without_sm.mat');
%load ('alex_without_sm.mat');

%����������������
count_total = 0;
correct_total = 0;
correct = zeros(size(label_name));
correct_rate = zeros(size(label_name));

%����ͼ��ʶ��ͼ�񣬼���
for i = 1:size(label_name)
    %ѡȡlabel_name�������е��ļ�����
    dirstruct = dir(['Caltech101-ImageNetLabel/',label_name{i}]);
    [D,~] = size(dirstruct);
    n = D-2;
    for j = 1:n
        
        %ÿ���ļ����б�������ͼƬ����ʾ�ļ�·�����ļ���
        filename = ['Caltech101-ImageNetLabel/',label_name{i},'/',dirstruct(j+2,1).name];
        disp(filename);
        
        %����ͼ��תͼ��Ϊ227*227��С
        tic;%��ʱ��ʼ
        I = imread(filename);
        I = imresize(I,[227,227]);
        if length(size(I)) == 3
            II = I;
        else
            %��Ϊ�Ҷ�ͼ����ת��ΪRGBͼ
            if length(size(I)) == 2
                II(:,:,1) = I;
                II(:,:,2) = I;
                II(:,:,3) = I;
            end
        end
        
        % category = activations(convnet,II,'classificationLayer');
        % [~,idx] = max(category);
        % result = convnet.Layers(end).ClassNames{idx};
        
        %�������һ������Layer
        category = activations(convnet,II,'fc8');
        %�ҵ�����������
        [~,idx] = max(category);
        %��'alex_without_nor.mat'�е�classes�ṹ���в��ҵ�������
        result = classes.name{idx};
        
        %�ж�result�Ƿ�����ڸ��ļ�������Ӧ��label����б���
        for k = 1:5
            if strcmp(label{i,k},result)
                correct_total = correct_total + 1;
                correct(i) = correct(i) + 1;
            end
        end
        
        count_total = count_total + 1;
        toc;%��ʱ����
    end
    correct_rate(i) = correct(i)/n;
end

%����׼ȷ��
correct_rate_total = correct_total/count_total;

save('runalex_result.mat','correct_rate','correct_rate_total','correct_total','count_total');