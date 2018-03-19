function net = cnnTrain(net,x,y,opts)
m = size(x,3);
numbatches = m / opts.batchsize;
 if rem(numbatches,1)  ~= 0
     error('numbatches not integer');
 end
 
 net.rl = [];
 
 for i = 1:opts.numepochs
     disp (['epoch' num2str(i) '/' num2str(opts.numepochs)]);
     tic;
     kk = randperm(m);
     for l = 1 :numbatches
         batch_x = x(:,:,kk((l-1)*opts.batchsize + 1 : l*opts.batchsize));
         batch_y = y(kk((l-1)*opts.batchsize + 1 : l*opts.batchsize),:);
         
         net = cnnff(net,batch_x);
         net = cnnbp(net,batch_y);
         %checkgrads(net,batch_x,batch_y);
         net = cnnapplyGrads(net,opts);
         if isempty(net.rl)
             net.rl(l) = net.L;
         end
         net.rl(end+1) = 0.99 * net.rl(end) + 0.01*net.L;
     end
     toc;
 end
 
end