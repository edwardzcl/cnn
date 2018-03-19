clear;
clc;


load('parameters.mat');


              %fc7                                      
        for l=1:4096
         for k=1:4096
             for m = 1:1
               for n=1:1
                    weight_71(l,k)=weight_7(m,n,k,l);
               end
             end
         end
        end
        
          %fc8                                                  
        for l=1:1000
         for k=1:4096
             for m = 1:1
               for n=1:1
                    weight_81(l,k)=weight_8(m,n,k,l);
               end
             end
         end  
        end
        
                                                        
