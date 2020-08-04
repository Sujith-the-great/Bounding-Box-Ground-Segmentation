function [number_classes,result] = sorting(y)
  m =length(y);
  a = y;
  for i=1:(m-1)
    for j=1:(m-1)
      % Ascending Order
      if a(j)>a(j+1)
        b = a(j);
        a(j) = a(j+1);
        a(j+1)=b;
      endif
    endfor
  endfor
b=1;
for i=1:(m-1)
  if a(i)!=a(i+1)
    b=b+1;
  endif
endfor  
number_classes = b;
result = zeros(number_classes,1);
result(1)=a(1);
b=1;
for i=1:(m-1)
  if a(i)!=a(i+1)
    b=b+1;
    result(b)=a(i+1);
  endif
endfor   
  
  

endfunction
