function y = diversity_factor(A)
  % Here A is the population which is born from par parent and y is the diversity factor matrix of the population.
  m = size(A);
  k = A(:,1:(m(2)/2)) - A(:,((m(2)/2)+1):m(2));
  p = sum((k.^2),2);
  p_mu = sum(p);
  y = p/p_mu;  
endfunction 