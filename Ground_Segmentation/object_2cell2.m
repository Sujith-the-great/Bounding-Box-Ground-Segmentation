function [K,nu_objects] = object_2cell2(K1,K2,threshold)
  m1 = size(K1,2);  m2 = size(K2,2); 
  K ={};  nu_objects = 0;
  D1 = K1; D2 = K2;
  for i = 1:m1
    for j = 1:m2
      comp(i,j)=object_yes(K1{i},K2{j},threshold);
    endfor
  endfor 
  checked1 = zeros(m1); checked2 = zeros(m2);
  for i = 1:m1
    if (checked1(i)==0)
      nu_objects = nu_objects+1;
      K{nu_objects}=[];
      checked1(i)=1;
      [y,chec1,chec2]=Mst(i,comp,checked1,checked2,1);  checked1 = chec1; checked2 = chec2;
      m = size(y,1);
      nu_K=0;
      for j = 1:m
        a=y(j,:);
        if (a(1)==1)
          nu_K = nu_K+size(K1{a(2)},1);
        else
          nu_K = nu_K+size(K2{a(2)},1);
        endif  
      endfor  
      K{nu_objects}=zeros(nu_K,3);
      nu_K =0 ;
      for j = 1:m
        a=y(j,:);
        if (a(1)==1)
          K{nu_objects}((nu_K+1):(nu_K+size(K1{a(2)},1)),:)=K1{a(2)}; nu_K = nu_K+size(K1{a(2)},1);
        else
          K{nu_objects}((nu_K+1):(nu_K+size(K2{a(2)},1)),:)=K2{a(2)}; nu_K = nu_K+size(K2{a(2)},1);
        endif  
      endfor  
    endif
  endfor
  for i = 1:m2
    if (checked2(i)==0)
      nu_objects = nu_objects+1;
      K{nu_objects}=K2{i};
    endif  
  endfor
endfunction


function y = object_yes(a,b,threshold)
  m1 = size(a,1);
  m2 = size(b,1);
  y=0;  tolsqr = threshold^2;
  for i = 1:m1
    k = a(i,:);
    for j = 1:m2
      l = b(j,:);
      if (dist_sqr(k,l)<=tolsqr)
        y=1; break;
      endif
    endfor
    if (y==1)
      break;
    endif
  endfor
endfunction


function y = dist_sqr(a,b)
   y = sum(((a-b).^2),2);
endfunction


function [y,check1,check2] = Mst(a,comp,checked1,checked2,level)
  m1 = size(comp,1);  m2 = size(comp,2);
  y = [level,a];
  checked1(a) = 1;
  for i = 1:m2
    if ((comp(a,i)==1)&(checked2(i)==0))
      checked2(i)=1;
      if (level==1)
        c=2;
      else 
        c=1;
      endif
      [d,chec2,chec1] = Mst(i,comp',checked2,checked1,c); checked1 = chec1;  checked2 = chec2;
      
      y = [y;d(:,1),d(:,2)];
    endif  
  endfor   
  check1 = checked1;check2 = checked2;
endfunction
