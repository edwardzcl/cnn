function category = vggnet(image)
%VGGNET 给定一幅图像，经过vggNet CNN，在ImageNet数据库中找到对应的
%label编号，编号格式为类似'n02317335'的char变量。
%   输入为一幅224*224*3的RGB图像

tic;%计时开始

%weight和bias数据都在parameter.mat文件里
load imagenet-vgg-vd-16.mat;
load('parameters.mat')

%conv1
image_conv1 = cnnConv(image,weight_11,[1,1]);
image_bias1 = cnnBias(image_conv1,bias_11);
image_relu1 = cnnRelu(image_bias1);
image_pad1 = cnnPadding(image_relu1,[1,1]);
image_conv1 = cnnConv(image_pad1,weight_12,[1,1]);
image_bias1 = cnnBias(image_conv1,bias_12);
image_relu1 = cnnRelu(image_bias1);
image_pad1 = cnnPadding(image_relu1,[1,1]);
image_pool1 = cnnPool(image_pad1,[2,2],[2,2]);


%conv2
image_conv2 = cnnConv(image_pool1,weight_21,[1,1]);
image_bias2 = cnnBias(image_conv2,bias_21);
image_relu2 = cnnRelu(image_bias2);
image_pad2 = cnnPadding(image_relu2,[1,1]);
image_conv2 = cnnConv(image_pad2,weight_22,[1,1]);
image_bias2 = cnnBias(image_conv2,bias_22);
image_relu2 = cnnRelu(image_bias2);
image_pad2 = cnnPadding(image_relu2,[1,1]);
image_pool2 = cnnPool(image_pad2,[2,2],[2,2]);


%conv3
image_conv3 = cnnConv(image_pool2,weight_31,[1,1]);
image_bias3 = cnnBias(image_conv3,bias_31);
image_relu3 = cnnRelu(image_bias3);
image_pad3 = cnnPadding(image_relu3,[1,1]);
image_conv3 = cnnConv(image_pad3,weight_32,[1,1]);
image_bias3 = cnnBias(image_conv3,bias_32);
image_relu3 = cnnRelu(image_bias3);
image_pad3 = cnnPadding(image_relu3,[1,1]);
image_conv3 = cnnConv(image_pad3,weight_33,[1,1]);
image_bias3 = cnnBias(image_conv3,bias_33);
image_relu3 = cnnRelu(image_bias3);
image_pad3 = cnnPadding(image_relu3,[1,1]);
image_pool3 = cnnPool(image_pad3,[2,2],[2,2]);


%conv4
image_conv4 = cnnConv(image_pool3,weight_41,[1,1]);
image_bias4 = cnnBias(image_conv4,bias_41);
image_relu4 = cnnRelu(image_bias4);
image_pad4 = cnnPadding(image_relu4,[1,1]);
image_conv4 = cnnConv(image_pad4,weight_42,[1,1]);
image_bias4 = cnnBias(image_conv4,bias_42);
image_relu4 = cnnRelu(image_bias4);
image_pad4 = cnnPadding(image_relu4,[1,1]);
image_conv4 = cnnConv(image_pad4,weight_43,[1,1]);
image_bias4 = cnnBias(image_conv4,bias_43);
image_relu4 = cnnRelu(image_bias4);
image_pad4 = cnnPadding(image_relu4,[1,1]);
image_pool4 = cnnPool(image_pad4,[2,2],[2,2]);


%conv5
image_conv5 = cnnConv(image_pool4,weight_51,[1,1]);
image_bias5 = cnnBias(image_conv5,bias_51);
image_relu5 = cnnRelu(image_bias5);
image_pad5 = cnnPadding(image_relu5,[1,1]);
image_conv5 = cnnConv(image_pad5,weight_52,[1,1]);
image_bias5 = cnnBias(image_conv5,bias_52);
image_relu5 = cnnRelu(image_bias5);
image_pad5 = cnnPadding(image_relu5,[1,1]);
image_conv5 = cnnConv(image_pad5,weight_53,[1,1]);
image_bias5 = cnnBias(image_conv5,bias_53);
image_relu5 = cnnRelu(image_bias5);
image_pad5 = cnnPadding(image_relu5,[1,1]);
image_pool5 = cnnPool(image_pad5,[2,2],[2,2]);


%fc6
%image_fc6 = cnnFC(image_pool5(:),weight_6,bias_6);
%image_relu6 = cnnRelu(image_fc6);
image_conv6 = cnnConv(image_pool5,weight_6,[1,1]);
image_bias6 = cnnBias(image_conv6,bias_6);
image_relu6 = cnnRelu(image_bias6);


%fc7
image_fc7 = cnnFC(image_relu6(:),weight_7,bias_7);
image_relu7 = cnnRelu(image_fc7);


%fc8
image_fc8 = cnnFC(image_relu7(:),weight_8,bias_8);
image_relu8 = cnnRelu(image_fc8)



%softmax,这里可以不用计算
%image_softmax = cnnSoftmax(image_relu8);

%在fc8的输出取最大值的位置，即为类别值
[~,category] = max(image_relu8);

toc;%计时结束
