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
