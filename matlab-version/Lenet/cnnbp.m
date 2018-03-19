function net = cnnbp(net,y)
n = numel(net.layers);
num = size(y,1);
groundTruth = zeros(10,num);
for j = 1 : num
    for i = 1 : 10
        if y(j) == i
            groundTruth(i,j) = 1;
        end
    end
end
%groundTruth1 = full(sparse(y,1:num,1));
%m1 =size(groundTruth(:),1); 
%m2 = size(net.layers{n}.a(:),1);
%if m1 ~= m2
%    x;
%end
%x1 = net.layers{n}.a;
net.L = -1 ./ num * groundTruth(:)' *  log(net.layers{n}.a(:)) ;
net.layers{n}.delta = -(groundTruth - net.layers{n}.a);
for l=n-1:-1:2
    if strcmp(net.layers{l}.type,'F6')
        %x = net.layers{l+1}.w';
        %p =  net.layers{l+1}.delta;
        net.layers{l}.delta = (net.layers{l+1}.w'* net.layers{l+1}.delta).* sigmoidGrad(net.layers{l}.z);
    end
    
    if strcmp(net.layers{l}.type,'C5')
        net.layers{l}.delta = net.layers{l+1}.w'* net.layers{l+1}.delta .* sigmoidGrad(net.layers{l}.z);
    end
    
    if strcmp(net.layers{l}.type,'S4')
        net.layers{l}.d = net.layers{l+1}.w'* net.layers{l+1}.delta;
        sa = size(net.layers{l}.a{1});
        for j = 1 : numel(net.layers{l}.a) 
            net.layers{l}.delta{j} = reshape(net.layers{l}.d(((j-1)*sa(1)*sa(2)+1) : j*sa(1)*sa(2),:),sa(1),sa(2),sa(3));
        end
    end
    
    if strcmp(net.layers{l}.type,'C3') || strcmp(net.layers{l}.type,'C1')
        for j = 1:numel(net.layers{l}.a)
            net.layers{l}.delta{j} = sigmoidGrad(net.layers{l}.z{j}) .* (expand(net.layers{l+1}.delta{j},[net.layers{l+1}.scale net.layers{l+1}.scale 1]) / net.layers{l+1}.scale^2);
        end
    end
    
    if strcmp(net.layers{l}.type , 'S2')
        for i = 1 : numel(net.layers{l}.a)
            z = zeros(size(net.layers{l}.a{1}));
            for j = 1 : numel(net.layers{l+1}.a)
                z = z + convn(net.layers{l+1}.delta{j},rot90(net.layers{l+1}.w{i}{j},2),'full');
            end
            net.layers{l}.delta{i} = z;
        end
    end    
end
% º∆À„Ã›∂»
for l = 2 : n
    if strcmp(net.layers{l}.type,'C3') || strcmp(net.layers{l}.type,'C1')
        for j = 1 : numel(net.layers{l}.a)
            for i = 1: numel(net.layers{l-1}.a)
                net.layers{l}.dw{i}{j} = convn(flipall(net.layers{l-1}.a{i}),net.layers{l}.delta{j},'valid') / size(net.layers{l}.delta{j},3);
            end
            net.layers{l}.db{j} = sum(net.layers{l}.delta{j}(:)) / size(net.layers{l}.delta{j},3);
        end
    end
    
    if strcmp(net.layers{l}.type,'C5')
        net.layers{l}.dw = net.layers{l}.delta * net.layers{l-1}.fv' / size(net.layers{l-1}.fv,2);
        net.layers{l}.db = mean(net.layers{l}.delta,2);
    end
    
    if strcmp(net.layers{l}.type,'F6')
        net.layers{l}.dw = net.layers{l}.delta * net.layers{l-1}.a' / size(net.layers{l-1}.a,2);
        %b = net.layers{l}.delta;
        net.layers{l}.db = mean(net.layers{l}.delta ,2);
        %db = net.layers{l}.db;
    end
    
    if strcmp(net.layers{l}.type,'Soft')
        net.layers{l}.dw = net.layers{l}.delta * net.layers{l-1}.a' / size(net.layers{l-1}.a,2);
        net.layers{l}.db = mean(net.layers{l}.delta,2);
    end
end

function grad = sigmoidGrad(x)
    e_x = exp(-x);
    grad = e_x ./ ((1 + e_x).^2); 
end
end