clear;
clc;

load('net-epoch-20-fc.mat');
[~,num] = size(net.layers);
for i=1:num
 if isequal(net.layers{1,i}.type ,'conv')
    transform = net.layers{1,i}.weights{1,1};
    transform = transform(:);
    [n,y] = hist(transform,1000);
    new_table = [y;n];
    file_name = ['D:\IMSLAB\Matlab\matconvnet-1.0-beta24\users\lenet\',net.layers{1,i}.name,'.mat'];
    save (file_name,'new_table');
    figure(i);
    clf; 
    hist(transform,1000);
    title(sprintf('%s',net.layers{1,i}.name));
    file_name1 = ['D:\IMSLAB\Matlab\matconvnet-1.0-beta24\users\lenet\',net.layers{1,i}.name,'.jpg'];
    saveas(figure(i),file_name1);
 end
end