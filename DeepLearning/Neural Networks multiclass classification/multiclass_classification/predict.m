function y = predict(A,OptTheta)
  y = zeros(size(A,1),1);
  for i=1:size(A,1)
    if sigma(A(i,:)*OptTheta)<0.5
      y(i,1)=0;
      else y(i,1)=1;
    endif
  endfor
endfunction
