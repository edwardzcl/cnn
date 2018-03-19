function net = cnnapplyGrads(net,opts)
for l = 2: numel(net.layers)
    if strcmp(net.layers{l}.type,'C1') || strcmp(net.layers{l}.type,'C3')
        for j = 1 : numel(net.layers{l}.a)
            for i = 1:numel(net.layers{l-1}.a)
                net.layers{l}.w{i}{j} = net.layers{l}.w{i}{j} - opts.alpha * net.layers{l}.dw{i}{j};
            end
            net.layers{l}.b{j} = net.layers{l}.b{j} - opts.alpha*net.layers{l}.db{j};
        end
    end
    
    if strcmp(net.layers{l}.type,'C5') || strcmp(net.layers{l}.type,'F6') || strcmp(net.layers{l}.type,'Soft')
        w = net.layers{l}.w;
        dw = opts.alpha * net.layers{l}.dw;
        net.layers{l}.w = net.layers{l}.w - opts.alpha * net.layers{l}.dw;
        w1 = net.layers{l}.w;
        net.layers{l}.b = net.layers{l}.b - opts.alpha * net.layers{l}.db;
    end
end
end