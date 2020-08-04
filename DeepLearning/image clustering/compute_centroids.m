function centroids = compute_centroids(X, idx, K)
  [m n] = size(X);
  centroids = zeros(K, n);
  k_vector=[];
for i=1:K
 k_vector =[k_vector;i];
endfor
 centroids = (1./sum(((idx')==k_vector),2)).*(((idx')==k_vector)*X);
endfunction
