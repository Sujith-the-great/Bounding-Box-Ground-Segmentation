function [y] = making_50_50_3(x)
  a = size(x,1);
  b = size(x,2);
  y = zeros(50,50);
  for i=1:a
    for j=1:b
      for k=1:3
      y(i,j,k) = x(i,j,k);
      endfor
    endfor
  endfor
endfunction
