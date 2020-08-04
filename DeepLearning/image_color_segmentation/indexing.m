function index_for_eachdata = indexing(x,mu_vector)
  k =size(mu_vector,1);
  m = size(x,1);
  for i=1:m
   [p,index_for_eachdata(i,1)] = min(sum(((mu_vector-(ones(k,1)*x(i,:))).^2),2));    
  endfor
 
endfunction
