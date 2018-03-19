clear;
clc;

load('net-epoch-20-fc.mat');
load('quantified_weights_fc.mat');
for i=1:8
  if isequal(net.layers{1,i}.type ,'conv')
    [x,y,z,d] = size(net.layers{1,i}.weights{1,1});
    for d0=1:d
        for z0=1:z
          for y0=1:y
             for x0=1:x
                 tic;
                 right = 128;
                 left = 1;
                 while( right - left > 1 )
                     mid = floor((left+right)/2);
                   if(net.layers{1,i}.weights{1,1}(x0,y0,z0,d0)< quantified_weights_fc(mid))
                       right = mid;
                   elseif(net.layers{1,i}.weights{1,1}(x0,y0,z0,d0)> quantified_weights_fc(mid))
                       left = mid;
                   else
                       break
                   end
                 end
                 left_results = abs(net.layers{1,i}.weights{1,1}(x0,y0,z0,d0) - quantified_weights_fc(left));
                 right_results = abs(net.layers{1,i}.weights{1,1}(x0,y0,z0,d0) - quantified_weights_fc(right));
                 if(left_results < right_results)
                     net.layers{1,i}.weights{1,1}(x0,y0,z0,d0) = quantified_weights_fc(left);
                 else
                     net.layers{1,i}.weights{1,1}(x0,y0,z0,d0) = quantified_weights_fc(right);
                 end
                 toc;
             end
          end
        end
    end
  end
end

% save 'imagenet-vgg-f-conv-quantized.mat';