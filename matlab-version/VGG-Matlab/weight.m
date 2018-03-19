clear;
clc;

%读入模型文件：imagenet-vgg-vd-16.mat,其没有Normalization层

load ('imagenet-vgg-vd-16.mat');
%load('label_ss.mat')
%load('parameters.mat')


%conv1
        for l=1:64
         for k=1:3
             for m = 1:3
               for n=1:3
                    weight_11(m,n,k,l)=layers{1,1}.weights{1,1}(m,n,k,l);
               end
             end
         end
           bias_11(l,1)=layers{1,1}.weights{1,2}(l,1);            
        end
        
        for l=1:64
         for k=1:64
             for m = 1:3
               for n=1:3
                   weight_12(m,n,k,l)=layers{1,3}.weights{1,1}(m,n,k,l);
               end
             end
         end
                 bias_12(l,1)=layers{1,3}.weights{1,2}(l,1); 
        end
        
       %conv2         
        for l=1:128
         for k=1:64
             for m = 1:3
               for n=1:3
                    weight_21(m,n,k,l)=layers{1,6}.weights{1,1}(m,n,k,l);
               end
             end
         end
         bias_21(l,1)=layers{1,6}.weights{1,2}(l,1); 
        end
        
                       
        for l=1:128
         for k=128
             for m = 1:3
               for n=1:3
                    weight_22(m,n,k,l)=layers{1,8}.weights{1,1}(m,n,k,l);
               end
             end
         end
         bias_22(l,1)=layers{1,8}.weights{1,2}(l,1); 
        end
        
       %conv3                         
        for l=1:256
         for k=1:128
             for m = 1:3
               for n=1:3
                    weight_31(m,n,k,l)=layers{1,11}.weights{1,1}(m,n,k,l);
               end
             end
         end
          bias_31(l,1)=layers{1,11}.weights{1,2}(l,1); 
        end
        
                                        
        for l=1:256
         for k=1:256
             for m = 1:3
               for n=1:3
                    weight_32(m,n,k,l)=layers{1,13}.weights{1,1}(m,n,k,l);
               end
             end
         end
         bias_32(l,1)=layers{1,13}.weights{1,2}(l,1); 
        end
        
                               
        for l=1:256
         for k=1:256
             for m = 1:3
               for n=1:3
                    weight_33(m,n,k,l)=layers{1,15}.weights{1,1}(m,n,k,l);
               end
             end
         end
         bias_33(l,1)=layers{1,15}.weights{1,2}(l,1); 
        end
        
              %conv4                        
        for l=1:512
         for k=1:256
             for m = 1:3
               for n=1:3
                    weight_41(m,n,k,l)=layers{1,18}.weights{1,1}(m,n,k,l);
               end
             end
         end
         bias_41(l,1)=layers{1,18}.weights{1,2}(l,1);
        end
        
                                               
       for l=1:512
         for k=1:512
             for m = 1:3
               for n=1:3
                    weight_42(m,n,k,l)=layers{1,20}.weights{1,1}(m,n,k,l);
               end
             end
         end
         bias_42(l,1)=layers{1,20}.weights{1,2}(l,1);
       end
        
                                                       
        for l=1:512
         for k=1:512
             for m = 1:3
               for n=1:3
                   weight_43(m,n,k,l)=layers{1,22}.weights{1,1}(m,n,k,l);
               end
             end
         end
         bias_43(l,1)=layers{1,22}.weights{1,2}(l,1);
        end
        
         %conv5                                            
        for l=1:512
         for k=1:512
             for m = 1:3
               for n=1:3
                    weight_51(m,n,k,l)=layers{1,25}.weights{1,1}(m,n,k,l);
               end
             end
         end
         bias_51(l,1)=layers{1,25}.weights{1,2}(l,1);
        end
        
        
        for l=1:512
         for k=1:512
             for m = 1:3
               for n=1:3
                    weight_52(m,n,k,l)=layers{1,27}.weights{1,1}(m,n,k,l);
               end
             end
         end
          bias_52(l,1)=layers{1,27}.weights{1,2}(l,1);
        end
        
                                                       
        for l=1:512
         for k=1:512
             for m = 1:3
               for n=1:3
                    weight_53(m,n,k,l)=layers{1,29}.weights{1,1}(m,n,k,l);
               end
             end
         end
        bias_53(l,1)=layers{1,29}.weights{1,2}(l,1);  
        end
        
        %fc6                                                 
        for l=1:4096
         for k=1:512
             for m = 1:7
               for n=1:7
                    weight_6(m,n,k,l)=layers{1,32}.weights{1,1}(m,n,k,l);
               end
             end
         end
         bias_6(l,1)=layers{1,32}.weights{1,2}(l,1);  
        end
        
              %fc7                                      
        for l=1:4096
         for k=1:4096
             for m = 1:1
               for n=1:1
                    weight_7(m,n,k,l)=layers{1,34}.weights{1,1}(m,n,k,l);
               end
             end
         end
         bias_7(l,1)=layers{1,34}.weights{1,2}(l,1);  
        end
        
          %fc8                                                  
        for l=1:1000
         for k=1:4096
             for m = 1:1
               for n=1:1
                    weight_8(m,n,k,l)=layers{1,36}.weights{1,1}(m,n,k,l);
               end
             end
         end
         bias_8(l,1)=layers{1,36}.weights{1,2}(l,1);  
        end
        
                                                        