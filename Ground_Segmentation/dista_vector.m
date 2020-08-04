function y = dista_vector(A,thet,sign)
  m = size(A,1);
  theta = sign*thet;
  image = A-(((A*theta)-ones(m,1))/(theta'*theta))*(theta');
  y = sign*sqrt(theta'*theta)*(sum((A-image),2)/sum(theta));
endfunction
