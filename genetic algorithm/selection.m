function y = selection(A,population_limit)
  m = size(A);
  k = best_factor(A)
  [f,fi] = sort(k);
  y = A(fi(m(1):(-1):(m(1)-population_limit+1)),1:(m(2)/2));
endfunction  

function y = diversity_factor(A)
  % Here A is the population which is born from par parent and y is the diversity factor matrix of the population.
  m = size(A);
  k = A(:,(m(2)/2)) - A(:,((m(2)/2)+1):m(2));
  p = sum((k.^2),2);
  p_mu = sum(p);
  y = p/p_mu;  
endfunction  

function y = best_factor(A)
  m = size(A);
  k = fitness(A(:,1:(m(2)/2)));
  su = sum(k);
  fitness_factor = k/su;
  y = diversity_factor(A)+fitness_factor;
endfunction  

function y = fitness(x)
  m = size(x);
  y = e.^sum(((x-ones(m)).^2),2);
endfunction
