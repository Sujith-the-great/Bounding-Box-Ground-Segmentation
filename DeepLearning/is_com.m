function y = proj(K)
  % K contains numbers with value logic 1 and ever other number out of those 16 contains logic 0.
  m = length(K);
  % Code :  and - 1 , or - 2, nand -3 , nor -4 , xor -5 , xnor - 6
  p_max_com=zeros(16);
  K_2_cell_0 = {};
  K_2_cell_1 = {};
  K_2_cell_2 = {};
  K_2_cell_3 = {};
  for i=1:(m-1)
    for j=(i+1):m
      a = bin_mat(K(i));
      b = bin_mat(K(j));
      t = is_com_1(a,b);
      if t(1,1)==0
        K_2_cell_0{size(K_2_cell_0,1)+1,1} = [a;b];
      elseif t(1,1)==1 
        K_2_cell_1{size(K_2_cell_1,1)+1,1} = [t(1,2),a,b];
      elseif t(1,1)==2
        
        K_2_cell_2{size(K_2_cell_2,1)+1,1} = [t(1,2:3),a,b];
      else 
        K_2_cell_3{size(K_2_cell_3,1)+1,1} = [t(1,2:4),a,b];
      endif
    endfor
  endfor
  K_2_cell_2
  K_2_cell_3
  
endfunction

function y = is_com_2(a,b)
 
  k1 = a(1:2); temp1=[]; 
   for i=1:4
     if i!=k1(1)&& i!=k1(2)
       temp1=[temp1,i];
     endif
   endfor
  k2 = b(1:2); temp2=[];
   for i=1:4
     if i!=k2(1)&& i!=k2(2)
       temp2=[temp2,i];
     endif
   endfor
    p1 =a(3:6)(temp1); p2= a(7:10)(temp1);
    p3 =b(3:6)(temp2); p4= b(7:10)(temp2);     
endfunction 

function y = is_com_1(a,b)
  n=0;
  for i=1:4
   if a(i)==b(i)
    n=n+1;
    y(1,(n+1))=i;
   endif
  endfor
  y(1,1)=n;
endfunction

function y = bin_mat(i)
  y(1,1)=floor(i/8);
  y(1,2)=floor((i-8*(y(1,1)))/4);
  y(1,3)=floor((i-(y(1,2)*4)-(y(1,1)*8))/2);
  y(1,4)=floor((i-(y(1,2)*4)-(y(1,1)*8)-(y(1,3)*2)));
endfunction
