function net = initialParameters(net,x)
inputmaps = 1;
mapsize = size(x,1);
for l=1:numel(net.layers)
    if strcmp (net.layers{l}.type,'C1')
        mapsize = mapsize - net.layers{l}.kernelsize + 1;
        fan_out = net.layers{l}.outputmaps*net.layers{l}.kernelsize^2;
        for j =1:net.layers{l}.outputmaps
            fan_in = inputmaps * net.layers{l}.kernelsize^2;
            for i = 1:inputmaps
                net.layers{l}.w{i}{j} = (rand(net.layers{l}.kernelsize)-0.5) * 2 * sqrt(6/(fan_in + fan_out));
            end
            net.layers{l}.b{j} = 0;
        end
        inputmaps = net.layers{l}.outputmaps;
    end
    
    if strcmp(net.layers{l}.type,'S2')
        for j = 1:inputmaps
            net.layers{l}.b{j} = 0;
            net.layers{l}.w{j} = (rand(6,1)-0.5) * 2 * sqrt(6/12);
        end
        mapsize = mapsize / net.layers{l}.scale;
    end
    
    if strcmp (net.layers{l}.type,'C3')
        mapsize = mapsize - net.layers{l}.kernelsize + 1;
        fan_out = net.layers{l}.kernelsize^2 * net.layers{l}.outputmaps;
        for j = 1:net.layers{l}.outputmaps
            fan_in = inputmaps * net.layers{l}.kernelsize^2;
            for i = 1: inputmaps
                net.layers{l}.w{i}{j} = (rand(net.layers{l}.kernelsize)-0.5) * 2 * sqrt(6/(fan_in + fan_out));
            end
            net.layers{l}.b{j} = 0;
        end
        inputmaps = net.layers{l}.outputmaps;
    end
    
    if strcmp(net.layers{l}.type,'S4')
        for j = 1 : inputmaps
            net.layers{l}.b{j} = 0;
            net.layers{l}.w{j} = (rand(6,1)-0.5) * 2 * sqrt(6/(inputmaps * 2));
        end
        mapsize = mapsize/net.layers{l}.scale;
    end
    
    if strcmp (net.layers{l}.type,'C5')
        fan_out = net.layers{l}.outputmaps;
        fan_in = inputmaps * mapsize^2;
        net.layers{l}.w = (rand(fan_out,fan_in) - 0.5) * 2 * sqrt(6/(fan_in + fan_out));
        net.layers{l}.b = zeros(fan_out,1);
        inputmaps = fan_out;
    end
    
    if strcmp(net.layers{l}.type,'F6')
        fan_in = inputmaps;
        fan_out = net.layers{l}.outputmaps;
        net.layers{l}.w = (rand(fan_out,fan_in)-0.5) * 2 * sqrt(6/(fan_in + fan_out));
        net.layers{l}.b = zeros(fan_out,1);
        inputmaps = fan_out;
    end
    
    if strcmp(net.layers{l}.type,'Soft')
        fan_in = inputmaps;
        fan_out = net.layers{l}.num_classes;
        net.layers{l}.w = (rand(fan_out,fan_in)-0.5) * 2 * sqrt(6/(fan_in+fan_out));
        net.layers{l}.b = zeros(fan_out,1);
    end
end
end
