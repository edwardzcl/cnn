%��ȡ������ƫ���ı���ʽ�汾
%����������ֱ�ӷ���mat���л�ȡ�ı���ʽ����ʽһһ��

clear;
clc;

load parameters.mat;
%ȫ���Ӳ�
fid1=fopen('fcbias.txt','w+');

for l=1:4096
    count1=fprintf(fid1,'%d\n',int16(bias_6(l,1)*2^13));
end 
        
for l=1:4096
    count1=fprintf(fid1,'%d\n',int16(bias_7(l,1)*2^13));
end 

for l=1:1000
    count1=fprintf(fid1,'%d\n',int16(bias_8(l,1)*2^13));
end

%�����
fid2=fopen('bias.txt','w+');

        for l=1:96
                    count1=fprintf(fid2,'%d\n',int16(bias_1(1,1,l)*2^13));
        end
  
        for l=1:256
                    count1=fprintf(fid2,'%d\n',int16(bias_2(1,1,l)*2^13));
        end
         
        for l=1:384
                    count1=fprintf(fid2,'%d\n',int16(bias_3(1,1,l)*2^13));
        end
        
        for l=1:384
                    count1=fprintf(fid2,'%d\n',int16(bias_4(1,1,l)*2^13));
        end      
        
        for l=1:256
                    count1=fprintf(fid2,'%d\n',int16(bias_5(1,1,l)*2^13));
        end 

        fclose(fid1);
        fclose(fid2);
        
        
        
        
        
        