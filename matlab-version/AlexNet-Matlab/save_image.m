clear;
clc;

load parameters.mat;


%����label����
%�����label_ss.mat��18�����࣬label_s.mat��47�����࣬label.mat��58������
load label_ss.mat;

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

%����������������
count_total = 0;
correct_total = 0;
correct = zeros(size(label_name));
correct_rate = zeros(size(label_name));

fid=fopen('image.txt','w+');

for i = 1:size(label_name)
    %ѡȡlabel_name�������е��ļ�����
    dirstruct = dir(['Caltech101-ImageNetLabel\',label_name{i}]);
    [D,~] = size(dirstruct);
    n = D-2;
    for j = 1:n
        
        %ÿ���ļ����б�������ͼƬ����ʾ�ļ�·�����ļ���
        filename = ['Caltech101-ImageNetLabel/',label_name{i},'/',dirstruct(j+2,1).name];
        disp(filename);
        
        %����ͼ��תͼ��Ϊ227*227��С
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
            %��Ϊ�Ҷ�ͼ����ת��ΪRGBͼ
            if length(size(I)) == 2
                II(:,:,1) = I;
                II(:,:,2) = I;
                II(:,:,3) = I;
            end
        end
        
        %��ȥͼ���ֵ������CNN��������ͼ
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
             

