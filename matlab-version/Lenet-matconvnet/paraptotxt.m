clear;
clc;

load('net-epoch-20-fc.mat');

for i=1:8
    if isequal(net.layers{1,i}.type ,'conv')
        for j =1:2
          mid = net.layers{1,i}.weights{1,j};
          mid = mid(:);
          if (j == 1)
          filename = ['D:\IMSLAB\Matlab\matconvnet-1.0-beta24\users\lenet\',net.layers{1,i}.name,'_1','.txt'];
          else
          filename = ['D:\IMSLAB\Matlab\matconvnet-1.0-beta24\users\lenet\',net.layers{1,i}.name,'_2','.txt'];    
          end
          dlmwrite(filename,mid,'precision','%.20f')
        end
    end
end

 for i=1:10
		a = exp(num[i]);
		sum += e_num[i];
	end