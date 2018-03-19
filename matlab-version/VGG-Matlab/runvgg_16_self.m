clear;
clc;

%读入模型文件：imagenet-vgg-vd-16.mat,其没有Normalization层

load ('imagenet-vgg-vd-16.mat');
load('label_ss.mat')
load('parameters.mat')

%定义两个计数变量
count_total = 0;
correct_total = 0;
correct = zeros(size(label_name));
correct_rate = zeros(size(label_name));
          
%         fid1=fopen('weight.txt','w+');
%         for l=1:96
%          for k=1:3
%              for m = 1:11
%                for n=1:11
%                     count1=fprintf(fid1,'%d\n',int16(weight_1(m,n,k,l)*2^10));
%                end
%              end
%          end
%         end
%         
%         for l=1:256
%          for k=1:48
%              for m = 1:5
%                for n=1:5
%                     count1=fprintf(fid1,'%d\n',int16(weight_2(m,n,k,l)*2^10));
%                end
%              end
%          end
%         end
%         
%         for l=1:384
%          for k=1:256
%              for m = 1:3
%                for n=1:3
%                     count1=fprintf(fid1,'%d\n',int16(weight_3(m,n,k,l)*2^10));
%                end
%              end
%          end
%         end
%         
%         for l=1:384
%          for k=1:192
%              for m = 1:3
%                for n=1:3
%                     count1=fprintf(fid1,'%d\n',int16(weight_4(m,n,k,l)*2^10));
%                end
%              end
%          end
%         end       
%         
%         for l=1:256
%          for k=1:192
%              for m = 1:3
%                for n=1:3
%                     count1=fprintf(fid1,'%d\n',int16(weight_5(m,n,k,l)*2^10));
%                end
%              end
%          end
%         end 
%       
%         fid2=fopen('fcweight.txt','w+');
%         for m = 1:4096
%          for n=1:9216
%                count1=fprintf(fid2,'%d\n',int16(weight_6(m,n)*2^10));
%          end
%         end
%      
%         for m = 1:4096
%          for n=1:4096
%                count1=fprintf(fid2,'%d\n',int16(weight_7(m,n)*2^10));
%          end
%         end
%         
%         for m = 1:1000
%          for n=1:4096
%                count1=fprintf(fid2,'%d\n',int16(weight_8(m,n)*2^10));
%          end
%         end
%         
%               
%          
%         fid3=fopen('bias.txt','w+');
%         for l=1:96
%                     count1=fprintf(fid3,'%d\n',int32(bias_1(1,1,l)*2^15));
%         end
%   
%         for l=1:256
%                     count1=fprintf(fid3,'%d\n',int32(bias_2(1,1,l)*2^15));
%         end
%          
%         for l=1:384
%                     count1=fprintf(fid3,'%d\n',int32(bias_3(1,1,l)*2^15));
%         end
%         
%         for l=1:384
%                     count1=fprintf(fid3,'%d\n',int32(bias_4(1,1,l)*2^15));
%         end      
%         
%         for l=1:256
%                     count1=fprintf(fid3,'%d\n',int32(bias_5(1,1,l)*2^15));
%         end 
%          
%         
%         
%         fid4=fopen('fcbias.txt','w+');
%         for l=1:4096
%                     count1=fprintf(fid4,'%d\n',int32(bias_6(l,1)*2^15));
%         end 
%         
%         for l=1:4096
%                     count1=fprintf(fid4,'%d\n',int32(bias_7(l,1)*2^15));
%         end 
%         for l=1:1000
%                     count1=fprintf(fid4,'%d\n',int32(bias_8(l,1)*2^15));
%         end
  

%       fid=fopen('image.txt','w+');

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
        I = imread(filename);
               % I(300,97:120,1)
               % I(300,97:120,2)
               % I(300,97:120,3)
   
        I = imresize(I,[224,224]);
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
        
%         max1=image(1,1,1);
%         for k=1:3
%             for m = 1:227
%                 for n=1:227
%                     if max1<image(m,n,k)
%                     max1=image(m,n,k);
%                     end
%                 end
%             end
%         end
%                              
%   max1
        
        
         
%读取图像
%            for k=1:3
%               for m = 1:227
%                  for n=1:227
%                       count1=fprintf(fid,'%5.8f\n',image(m,n,k));
%                  end
%               end
%            end
%     end
% end
%          fclose(fid);    
        
        
        
        
%         fid5=fopen('classes.txt','w+');
%         for l=1:1000
%               count1=fprintf(fid5,'%s\n',classes.name{1,l});
%         end
%         
%         fid6=fopen('label.txt','w+');
%         for l=1:18
%             for m=1:4
%               count1=fprintf(fid6,'%s\n',label{l,m});
%             end
%         end
%         
%         
%         
%         
        %带入vggNet，得到输出分类序号
        category = vggnet_16(image);
        %在'imagenet-vgg-vd-16.mat'中的classes结构体中查找到输出结果
        result = classes.name{1,category}
        
        %判断result是否包含在该文件夹所对应的label编号列表中
        for k = 1:5
            if strcmp(label{i,k},result)
                correct_total = correct_total + 1;
                correct(i) = correct(i) + 1;
            end
        end
        
        count_total = count_total + 1;
    end
    correct_rate(i) = correct(i)/n;
end

%计算准确率
correct_rate_total = correct_total/count_total;

save('runalex_self_result.mat','correct_rate','correct_rate_total','correct_total','count_total');