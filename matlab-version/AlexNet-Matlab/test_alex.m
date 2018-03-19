clear;
clc;

%����ģ���ļ���imagenet-caffe-alex.mat����ԭʼģ���ļ�
%convnet = helperImportMatConvNet('imagenet-caffe-alex.mat');
%load ('imagenet-caffe-alex.mat');

%����ģ���ļ���alex_without_nor.mat,�䱻��Ϊȥ��Normalization��
%convnet = helperImportMatConvNet('alex_without_nor.mat');
load ('alex_without_nor.mat');

%����ģ���ļ���alex_without_nor_sm.mat,�䱻��Ϊȥ��Normalization�������softmax��
%convnet = helperImportMatConvNet('alex_without_nor_sm.mat');
%load ('alex_without_nor_sm.mat');

%����ģ���ļ���alex_without_sm.mat,�䱻��Ϊȥ������softmax��,����Normalization��
%convnet = helperImportMatConvNet('alex_without_sm.mat');
%load ('alex_without_sm.mat');

%ָ��������ͼƬ
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

%��ȥͼ���ֵ������CNN��������ͼ
image = single(II) - normalization.averageImage;
%����AlexNet���õ�����������
category = alexnet(image);
%��'alex_without_nor.mat'�е�classes�ṹ���в��ҵ�������
result = classes.name{category};