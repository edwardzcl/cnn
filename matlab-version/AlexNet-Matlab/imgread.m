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

%遍历图像，识别图像，计数
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
        I = imread(filename)
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
        
        %减去图像均值，生成CNN输入特征图
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


      
 