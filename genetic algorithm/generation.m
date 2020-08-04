function y = generation(par1,par2,mutate_percent,gen_cross_num,gen_mut_num);
  %% Here par is the selected parent.
  m = size(par1,2);
  y=[par1,par1;par2,par2];
  for i=1:floor(gen_cross_num/2)
    k=[];
    c1 = ceil(m*rand);
    c2 = ceil(m*rand);
    if (c1==0)
      c1=1;
    endif
    if (c2==0)
      c2=1;
    endif
    if (c2<c1)
      t=c1;
      c1 = c2;
      c2 = t;
    endif   
     k = [par1;par2];
     k(:,c1:c2)=[par2(1,c1:c2);par1(1,c1:c2)]
     for j =1:gen_mut_num  
       t=k;
       mut_p = ceil(m*rand); 
       if (mut_p==0)
         mut_p =1;
       endif  
       t(1,mut_p) = t(1,mut_p)*(1+mutate_percent/100*((-1)+2*(rand)))
       mut_p = ceil(m*rand); 
       if (mut_p==0)
         mut_p =1;
       endif  
       t(2,mut_p) = t(2,mut_p)*(1+mutate_percent/100*((-1)+2*(rand)))
       t = [t,[par1;par2]];
       y = [y;t];
     endfor   
  endfor  
endfunction   