%根据需要进行格式转换，把文本变为mat格式
VarName=VarName(16777217:end);
% for i=1:256
%     for j=1:192
%         for k=1:3
%             for l=1:3
%                 weight5(k,l,j,i)=VarName1(1728*(i-1)+9*(j-1)+3*(k-1)+l);
%             end
%         end
%     end
% end

% for i=1:1000
%     for j=1:4096
%         weight8(i,j)=VarName1(1000*(i-1)+j);
%     end
% end

for i=1:1000
    for j=1:4096
        weight8(i,j)=VarName(4096*(i-1)+j);
    end
end