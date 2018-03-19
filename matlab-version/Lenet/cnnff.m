function net = cnnff(net,x)
n = numel(net.layers);
net.layers{1}.a{1} = x;
inputmaps = 1;
num = size(x,3);
for l = 2:n
    if strcmp(net.layers{l}.type,'C1') || strcmp(net.layers{l}.type,'C3')
        for j = 1 : net.layers{l}.outputmaps
            z = zeros(size(net.layers{l-1}.a{1}) - [net.layers{l}.kernelsize - 1 net.layers{l}.kernelsize - 1 0]);
            for i = 1 : inputmaps
                z = z + convn(net.layers{l-1}.a{i},net.layers{l}.w{i}{j},'valid');
            end
            %b = net.layers{l}.b{j};
            net.layers{l}.z{j} = z + net.layers{l}.b{j} .* ones(size(z));
            %z1 = reshape(net.layers{l}.z{j},[],40);
            net.layers{l}.a{j} = sigm(net.layers{l}.z{j});
        end
        inputmaps = net.layers{l}.outputmaps;
    end
    
    if strcmp(net.layers{l}.type , 'S2') || strcmp(net.layers{l}.type,'S4');
        for j = 1:inputmaps
            z = convn(net.layers{l-1}.a{j},ones(net.layers{l}.scale)/(net.layers{l}.scale^2),'valid');
            net.layers{l}.a{j} = z(1:net.layers{l}.scale:end,1:net.layers{l}.scale:end,:);
            %z2 = reshape(net.layers{l}.a{j},[],40);
        end
    end
    
    if strcmp(net.layers{l}.type,'C5')
        net.layers{l-1}.fv = [];
        for j = 1:numel(net.layers{l-1}.a)
            sa = size(net.layers{l-1}.a{j});
            net.layers{l-1}.fv = [net.layers{l-1}.fv;reshape(net.layers{l-1}.a{j},sa(1)*sa(2),sa(3))];
        end
        %x =  net.layers{l}.w ;
        %p = net.layers{l-1}.fv;
        net.layers{l}.z = net.layers{l}.w * net.layers{l-1}.fv + repmat(net.layers{l}.b,1,num);
        net.layers{l}.a = sigm(net.layers{l}.z );
        %z3 = net.layers{l}.a;
        inputmaps = size(net.layers{l}.a,1);
    end
    
    if strcmp (net.layers{l}.type,'F6')
        net.layers{l}.z = net.layers{l}.w * net.layers{l-1}.a+ repmat(net.layers{l}.b,1,num);
        net.layers{l}.a = sigm(net.layers{l}.z );
    end
    
    if strcmp(net.layers{l}.type,'Soft')
        net.layers{l}.z = net.layers{l}.w * net.layers{l-1}.a + repmat(net.layers{l}.b,1,num);
        %z1 = net.layers{l}.z;
        net.layers{l}.z = bsxfun(@minus,net.layers{l}.z,max(net.layers{l}.z,[],1));
        %z2 = net.layers{l}.z;
        net.layers{l}.z = exp(net.layers{l}.z);
        %z3 = net.layers{l}.z;
        net.layers{l}.a = bsxfun(@rdivide,net.layers{l}.z,sum(net.layers{l}.z));
        %x1 = net.layers{l}.a;
    end
end
end