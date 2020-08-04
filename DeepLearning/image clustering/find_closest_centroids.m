function idx = find_closest_centroids(x,mu_vector)
  m = size(x,1);
  dimen = size(x,2);
  k = size(mu_vector,1);
  %centroid vector
  for i=1:m
   [p,idx(i,1)] = min(sum(((mu_vector-(ones(k,1)*x(i,:))).^2),2));    
  endfor
 
endfunction
