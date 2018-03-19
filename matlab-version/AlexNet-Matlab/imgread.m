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

%����ͼ��ʶ��ͼ�񣬼���
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
        I = imread(filename)
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
        
        %��ȥͼ���ֵ������CNN��������ͼ
        image = single(II) - normalization.averageImage;
        
         

           for k=1:3
              for m = 1:227
                 for n=1:227
                      count1=fprintf(fid,'%5.8f\n',image(m,n,k));
                 end
              end
           end

%          fclose(fid);
%          
%         fid1=fopen('weight.txt','w+');
%         for l=1:96
%          for k=1:3
%              for m = 1:11
%                for n=1:11
%                     count1=fprintf(fid1,'%5.8f\n',weight_1(m,n,k,l));
%                end
%              end
%          end
%         end
%         
%         for l=1:256
%          for k=1:48
%              for m = 1:5
%                for n=1:5
%                     count1=fprintf(fid1,'%5.8f\n',weight_2(m,n,k,l));
%                end
%              end
%          end
%         end
%         
%         for l=1:384
%          for k=1:256
%              for m = 1:3
%                for n=1:3
%                     count1=fprintf(fid1,'%5.8f\n',weight_3(m,n,k,l));
%                end
%              end
%          end
%         end
%         
%         for l=1:384
%          for k=1:192
%              for m = 1:3
%                for n=1:3
%                     count1=fprintf(fid1,'%5.8f\n',weight_4(m,n,k,l));
%                end
%              end
%          end
%         end       
%         
%         for l=1:256
%          for k=1:192
%              for m = 1:3
%                for n=1:3
%                     count1=fprintf(fid1,'%5.8f\n',weight_5(m,n,k,l));
%                end
%              end
%          end
%         end 
%       
%         fid2=fopen('fcweight.txt','w+');
%         for m = 1:4096
%          for n=1:9216
%                count1=fprintf(fid2,'%5.8f\n',weight_6(m,n));
%          end
%         end
%      
%         for m = 1:4096
%          for n=1:4096
%                count1=fprintf(fid2,'%5.8f\n',weight_7(m,n));
%          end
%         end
%         
%         for m = 1:1000
%          for n=1:4096
%                count1=fprintf(fid2,'%5.8f\n',weight_8(m,n));
%          end
%         end
%         
%         
%         
%         
%          
%         fid3=fopen('bias.txt','w+');
%         for l=1:96
%                     count1=fprintf(fid3,'%5.8f\n',bias_1(1,1,l));
%         end
%   
%         for l=1:256
%                     count1=fprintf(fid3,'%5.8f\n',bias_2(1,1,l));
%         end
%          
%         for l=1:384
%                     count1=fprintf(fid3,'%5.8f\n',bias_3(1,1,l));
%         end
%         
%         for l=1:384
%                     count1=fprintf(fid3,'%5.8f\n',bias_4(1,1,l));
%         end      
%         
%         for l=1:256
%                     count1=fprintf(fid3,'%5.8f\n',bias_5(1,1,l));
%         end 
%          
%         
%         
%         fid4=fopen('fcbias.txt','w+');
%         for l=1:4096
%                     count1=fprintf(fid4,'%5.8f\n',bias_6(l,1));
%         end 
%         
%         for l=1:4096
%                     count1=fprintf(fid4,'%5.8f\n',bias_7(l,1));
%         end 
%         for l=1:1000
%                     count1=fprintf(fid4,'%5.8f\n',bias_8(l,1));
%         end
%         
        
    end

end

fclose(fid);


      
 