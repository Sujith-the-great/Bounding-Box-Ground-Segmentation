function [K,nu_objects] = object_2cell(K1,K2,threshold)

  m1 = size(K1,2);
  m2 = size(K2,2);
  m = m1 + m2;
  Kd = {K1{1:m1},K2{1:m2}};
  nu_objects=0;
  if (m==0)
    K ={}; nu_objects=0;
  else 
    while (size(Kd,2)!=0)
      nu_objects =nu_objects+1;
      K{nu_objects}=Kd{1};
      Kd = {Kd{2:end}};
      stage1 = {K{nu_objects}}; stage2={}; t=[]; nu_stage2 =0;
      while ((size(stage1,2)!=0)&(size(Kd,2)!=0))
        nu_stage1 = size(stage1,2);
        for j=1:nu_stage1
          a=stage1{j};
          i=1;
          while (i<=size(Kd,2))
            if (object_yes(a,Kd{i},threshold)==1)
              nu_stage2=nu_stage2+1; stage2{nu_stage2}=Kd{i}; Kd = {Kd{1:(i-1)},Kd{(i+1):end}}; t = [t;stage2{nu_stage2}];
            else
              i=i+1;
            endif  
          endwhile
        endfor
        K{nu_objects}=[K{nu_objects};t];  stage1 = stage2; stage2={}; t=[];
      endwhile  
        
    endwhile
  endif
  
  
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
