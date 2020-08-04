function [p] = feature_matrix(q)
  p = reshape(making_50_50(imread(q)),2500,1);
endfunction 







function [y] = making_50_50(x)
  [a b] = size(x);
  y = zeros(50,50);
  for i=1:a
    for j=1:b
      y(i,j) = x(i,j);
    endfor
  endfor
endfunction
