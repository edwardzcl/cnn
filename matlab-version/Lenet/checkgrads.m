function checkgrads(net,x,y)
epsilon = 1e-4;
er      = 1e-8;
n = numel(net.layers);
for l = n : -1 : 2
    if strcmp(net.layers{l}.type,'Soft')
        for j = 1 : numel(net.layers{l}.b)
            net_m = net; net_p = net;
            net_p.layers{l}.b(j) = net_m.layers{l}.b(j) + epsilon;
            net_m.layers{l}.b(j) = net_m.layers{l}.b(j) - epsilon;
            net_m = cnnff(net_m,x);net_m = cnnbp(net_m,y);
            net_p = cnnff(net_p,x);net_p = cnnbp(net_p,y);
            d = (net_p.L - net_m.L) / (2 * epsilon);
            e = abs(d - net.layers{l}.db(j));
            if e > er
                error('numrical graddient checking failed at softb');
            end
        end
        
        for i = 1 : size(net.layers{l}.w,1)
            for j = 1 : size(net.layers{l}.w,2)
                net_m = net; net_p = net;
                net_p.layers{l}.w(i,j) = net_p.layers{l}.w(i,j) + epsilon;
                net_m.layers{l}.w(i,j) = net_m.layers{l}.w(i,j) - epsilon;
                net_m = cnnff(net_m,x); net_m = cnnbp(net_m,y);
                net_p = cnnff(net_p,x); net_p = cnnbp(net_p,y);
                d = (net_p.L - net_m.L)/(2*epsilon);
                e = abs(d - net.layers{l}.dw(i,j));
                if e > er
                    error('numrical graddient checking faild at softw');
                end
            end
        end
    end
    
    if strcmp(net.layers{l}.type,'F6')
        for j = 1 : size(net.layers{l}.b,1)
            net_m = net;net_p = net;
            net_p.layers{l}.b(j) = net_p.layers{l}.b(j) + epsilon;
            net_m.layers{l}.b(j) = net_m.layers{l}.b(j) - epsilon;
            net_p = cnnff(net_p,x); net_p = cnnbp(net_p,y);
            net_m = cnnff(net_m,x); net_m = cnnbp(net_m,y);
            %db = net.layers{l}.db(j);
            d = (net_p.L - net_m.L) / (2 * epsilon);
            e = abs(d - net.layers{l}.db(j));
            if e > er
                error('numrical graddient checking failed at F6b');
            end
        end
        for i = 1 : size(net.layers{l}.w,1)
            for j = 1 : size(net.layers{l}.w,2)
                net_m = net;net_p = net;
                net_p.layers{l}.w(i,j) = net_p.layers{l}.w(i,j) + epsilon;
                net_m.layers{l}.w(i,j) = net_m.layers{l}.w(i,j) - epsilon;
                net_p = cnnff(net_p,x);net_p =cnnbp(net_p,y);
                net_m = cnnff(net_m,x);net_m = cnnbp(net_m,y);
                d = (net_p.L - net_m.L) / (2 * epsilon);
                e = abs(d - net.layers{l}.dw(i,j));
                if e > er
                    error('numrical gradient checking failed at F6w');
                end
            end
        end
    end
    
    if strcmp(net.layers{l}.type,'C5')
        for i = 1 : size(net.layers{l}.w,1)
            for j = 1 : size(net.layers{l}.w,2)
                net_m = net;net_p = net;
                net_p.layers{l}.w(i,j) = net_p.layers{l}.w(i,j) + epsilon;
                net_m.layers{l}.w(i,j) = net_m.layers{l}.w(i,j) - epsilon;
                net_p = cnnff(net_p,x); net_p = cnnbp(net_p,y);
                net_m = cnnff(net_m,x); net_m = cnnbp(net_m,y);
                d = (net_p.L - net_m.L) / (2 * epsilon);
                e = abs(d - net.layers{l}.dw(i,j));
                if e > er
                    error('numrical gradient checking failed at C5w');
                end
            end
        end
        
        for j = 1 : size(net.layers{l}.b,1)
            net_m = net;net_p = net;
            net_p.layers{l}.b(j) = net_p.layers{l}.b(j) + epsilon;
            net_m.layers{l}.b(j) = net_m.layers{l}.b(j) - epsilon;
            net_p = cnnff(net_p,x); net_p = cnnbp(net_p,y);
            net_m = cnnff(net_m,x); net_m = cnnbp(net_m,y);
            d = (net_p.L - net_m.L) /  (2 * epsilon);
            e = abs(d - net.layers{l}.b(j));
            if e > er
                error('numrical gradient checking failed at C5b');
            end
        end
    end
    
    if strcmp(net.layers{l}.type,'C3') 
        for j = 1 : numel(net.layers{l}.a)
            net_m = net; net_p = net;
            net_p.layers{l}.b{j} = net_p.layers{l}.b{j} + epsilon;
            net_m.layers{l}.b{j} = net_m.layers{l}.b{j} - epsilon;
            net_p = cnnff(net_p,x); net_p = cnnbp(net_p,y);
            net_m = cnnff(net_m,x); net_m = cnnbp(net_m,y);
            d = (net_p.L - net_m.L) / (2*epsilon);
            e = abs(d - net.layers{l}.db{j});
            if e > er
                error('numrical gradient checking failed at C3b');
            end
            for i = 1 : numel(net.layers{l-1}.a)
                for u = 1 : size(net.layers{l}.w{i}{j},1)
                    for v = 1 : size(net.layers{l}.w{i}{j},2)
                        net_m = net; net_p = net;
                        net_p.layers{l}.w{i}{j}(u,v) = net_p.layers{l}.w{i}{j}(u,v) + epsilon;
                        net_m.layers{l}.w{i}{j}(u,v) = net_m.layers{l}.w{i}{j}(u,v) - epsilon;
                        net_p = cnnff(net_p,x); net_p = cnnbp(net_p,y);
                        net_m = cnnff(net_m,x); net_m = cnnbp(net_m,y);
                        d = (net_p.L - net_m.L) / (2*epsilon);
                        e = abs(d - net.layers{l}.dw{i}{j}(u,v));
                        if e > er
                            error('numrical gradient checking failed at C3w');
                        end
                    end
                end
            end
        end
    end
    if strcmp(net.layers{l}.type,'C1') 
        for j = 1 : numel(net.layers{l}.a)
            net_m = net; net_p = net;
            net_p.layers{l}.b{j} = net_p.layers{l}.b{j} + epsilon;
            net_m.layers{l}.b{j} = net_m.layers{l}.b{j} - epsilon;
            net_p = cnnff(net_p,x); net_p = cnnbp(net_p,y);
            net_m = cnnff(net_m,x); net_m = cnnbp(net_m,y);
            d = (net_p.L - net_m.L) / (2*epsilon);
            e = abs(d - net.layers{l}.db{j});
            if e > er
                error('numrical gradient checking failed at C1b');
            end
            for i = 1 : numel(net.layers{l-1}.a)
                for u = 1 : size(net.layers{l}.w{i}{j},1)
                    for v = 1 : size(net.layers{l}.w{i}{j},2)
                        net_m = net; net_p = net;
                        net_p.layers{l}.w{i}{j}(u,v) = net_p.layers{l}.w{i}{j}(u,v) + epsilon;
                        net_m.layers{l}.w{i}{j}(u,v) = net_m.layers{l}.w{i}{j}(u,v) - epsilon;
                        net_p = cnnff(net_p,x); net_p = cnnbp(net_p,y);
                        net_m = cnnff(net_m,x); net_m = cnnbp(net_m,y);
                        d = (net_p.L - net_m.L) / (2*epsilon);
                        e = abs(d - net.layers{l}.dw{i}{j}(u,v));
                        if e > er
                            error('numrical gradient checking failed at C1w');
                        end
                    end
                end
            end
        end
    end
end

end