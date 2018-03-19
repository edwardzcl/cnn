function category = alexnet(image)
%ALEXNET ����һ��ͼ�񣬾���AlexNet CNN����ImageNet���ݿ����ҵ���Ӧ��
%label��ţ���Ÿ�ʽΪ����'n02317335'��char������
%   ����Ϊһ��227*227*3��RGBͼ��

tic;%��ʱ��ʼ

%weight��bias���ݶ���parameter.mat�ļ���
load parameters.mat;

%conv1
image_conv1 = cnnConv(image,weight_1,[4,4]);

% max1=image_conv1(1,1,1);
% for k=1:96
%     for m = 1:55
%         for n=1:55
%             if max1<image_conv1(m,n,k)
%                 max1=image_conv1(m,n,k);
%             end
%         end
%     end
% end        
%   %max1  


image_bias1 = cnnBias(image_conv1,bias_1);
image_relu1 = cnnRelu(image_bias1);
image_pool1 = cnnPool(image_relu1,[3,3],[2,2]);

% max1=image_pool1(1,1,1);
% for k=1:96
%     for m = 1:27
%         for n=1:27
%             if max1<image_pool1(m,n,k)
%                 max1=image_pool1(m,n,k);
%             end
%         end
%     end
% end        
%   max1 

%�м�����ͼ�Ŀ��ӻ�
% figure(6);
% for i = 1:96
%     subplot(8,12,i);
%     imagesc(image_bias1(:,:,i));
%     axis off;
% end

%conv2
%����ľ����Ҫ���Ϊ���������㣬ÿ����Ϊ�ϲ�������е�128������ͼ
%�ھ�������󣬽������2���ֱַ�128������ͼ���¶ѵ�Ϊ256������ͼ
image_pad2 = cnnPadding(image_pool1,[2,2]);
image_conv2(:,:,1:128) = cnnConv(image_pad2(:,:,1:48),weight_2(:,:,:,1:128),[1,1]);
image_conv2(:,:,129:256) = cnnConv(image_pad2(:,:,49:96),weight_2(:,:,:,129:256),[1,1]);
image_bias2 = cnnBias(image_conv2,bias_2);
image_relu2 = cnnRelu(image_bias2);
image_pool2 = cnnPool(image_relu2,[3,3],[2,2]);

% max1=image_pool2(1,1,1);
% for k=1:256
%     for m = 1:13
%         for n=1:13
%             if max1<image_pool2(m,n,k)
%                 max1=image_pool2(m,n,k);
%             end
%         end
%     end
% end        
%   max1 


% figure(7);
% for i = 1:256
%     subplot(16,16,i);
%     imagesc(image_bias2(:,:,i));
%     axis off;
% end

%conv3
image_pad3 = cnnPadding(image_pool2,[1,1]);
image_conv3 = cnnConv(image_pad3,weight_3,[1,1]);
image_bias3 = cnnBias(image_conv3,bias_3);
image_relu3 = cnnRelu(image_bias3);

% max1=image_relu3(1,1,1);
% for k=1:384
%     for m = 1:13
%         for n=1:13
%             if max1<image_relu3(m,n,k)
%                 max1=image_relu3(m,n,k);
%             end
%         end
%     end
% end        
%   max1 


% figure(8);
% for i = 1:384
%     subplot(16,24,i);
%     imagesc(image_bias3(:,:,i));
%     axis off;
% end

%conv4
%����ľ����Ҫ���Ϊ���������㣬ÿ����Ϊ�ϲ�������е�192������ͼ
%�ھ�������󣬽������2���ֱַ�192������ͼ���¶ѵ�Ϊ384������ͼ
image_pad4 = cnnPadding(image_relu3,[1,1]);
image_conv4(:,:,1:192) = cnnConv(image_pad4(:,:,1:192),weight_4(:,:,:,1:192),[1,1]);
image_conv4(:,:,193:384) = cnnConv(image_pad4(:,:,193:384),weight_4(:,:,:,193:384),[1,1]);
image_bias4 = cnnBias(image_conv4,bias_4);
image_relu4 = cnnRelu(image_bias4);

% max1=image_relu4(1,1,1);
% for k=1:384
%     for m = 1:13
%         for n=1:13
%             if max1<image_relu4(m,n,k)
%                 max1=image_relu4(m,n,k);
%             end
%         end
%     end
% end        
%   max1 





% figure(9);
% for i = 1:384
%     subplot(16,24,i);
%     imagesc(image_bias4(:,:,i));
%     axis off;
% end

%conv5
%����ľ����Ҫ���Ϊ���������㣬ÿ����Ϊ�ϲ�������е�192������ͼ
%�ھ�������󣬽������2���ֱַ�128������ͼ���¶ѵ�Ϊ256������ͼ
image_pad5 = cnnPadding(image_relu4,[1,1]);
image_conv5(:,:,1:128) = cnnConv(image_pad5(:,:,1:192),weight_5(:,:,:,1:128),[1,1]);
image_conv5(:,:,129:256) = cnnConv(image_pad5(:,:,193:384),weight_5(:,:,:,129:256),[1,1]);
image_bias5 = cnnBias(image_conv5,bias_5);
image_relu5 = cnnRelu(image_bias5);
image_pool5 = cnnPool(image_relu5,[3,3],[2,2]);

% max1=image_pool5(1,1,1);
% for k=1:256
%     for m = 1:6
%         for n=1:6
%             if max1<image_pool5(m,n,k)
%                 max1=image_pool5(m,n,k);
%             end
%         end
%     end
% end        
%   max1 



% figure(10);
% for i = 1:256
%     subplot(16,16,i);
%     imagesc(image_bias5(:,:,i));
%     axis off;
% end

%fc6
image_fc6 = cnnFC(image_pool5(:),weight_6,bias_6);
image_relu6 = cnnRelu(image_fc6);

% max1=image_relu6(1);
%         for n=1:4096
%             if max1<image_relu6(n)
%                 max1=image_relu6(n);
%             end
%         end   
%   %max1 




%fc7
image_fc7 = cnnFC(image_relu6(:),weight_7,bias_7);
image_relu7 = cnnRelu(image_fc7);


% max1=image_relu7(1);
%         for n=1:4096
%             if max1<image_relu7(n)
%                 max1=image_relu7(n);
%             end
%         end   
%   %max1 



%fc8
image_fc8 = cnnFC(image_relu7(:),weight_8,bias_8);
image_relu8 = cnnRelu(image_fc8)


% max1=image_relu8(1);
%         for n=1:1000
%             if max1<image_relu8(n)
%                 max1=image_relu8(n);
%             end
%         end   
%   max1 



%softmax,������Բ��ü���
%image_softmax = cnnSoftmax(image_relu8);

%��fc8�����ȡ���ֵ��λ�ã���Ϊ���ֵ
[~,category] = max(image_relu8);

toc;%��ʱ����
