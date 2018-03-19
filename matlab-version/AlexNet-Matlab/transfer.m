        clear;
        clc;
        fid1=fopen('image.txt','r+');
        array=fscanf(fid1,'%f');
        fid2=fopen('image0.txt','w+');
        l=length(array);
        for i=1:l
        count1=fprintf(fid2,'%d\n',int32(array(i)*2^3));
        end
        
        fclose(fid1);
        fclose(fid2);

%         fid3=fopen('bias.txt','r+');
%         array=fscanf(fid3,'%d');
%         fid4=fopen('bias1.txt','w+');
%         l=length(array);
%         for i=1:l
%         count1=fprintf(fid4,'%d\n',int32(array(i)/4));
%         end
%         
%         fclose(fid3);
%         fclose(fid4);
%         
%         fid5=fopen('fcbias.txt','r+');
%         array=fscanf(fid5,'%d');
%         fid6=fopen('fcbias1.txt','w+');
%         l=length(array);
%         for i=1:l
%         count1=fprintf(fid6,'%d\n',int32(array(i)/4));
%         end
%         
%         fclose(fid5);
%         fclose(fid6);
