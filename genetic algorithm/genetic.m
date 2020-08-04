function fittest_person = genetic(initial_population,population_limit,mutate_percent,gen_cross_num,gen_mut_num,diversity_threshold)
 %% person or chromosome =[g1 g2 g3 g4 g5 g6 g7 ....] genes vector
 %% initial_population = set of initial persons
 %% we have to define a fitness function
 %% then we have to mutate and crossover the genes of a pair of persons( say fittest). For this we have to increase the population until a certain limit and mutate step percent and if it exceeds it we have to select the fittest. 
  d=1;
  while(d==1)
   m = size(initial_population);
   [f,fi] = sort(fitness(initial_population));
   initial_population = initial_population(fi,:);
   fittest = initial_population(m(1),:) 
   a=[];
     for i=1:(m(1)-1)
       k = initial_population(i,:);
       a = [a;generation(k,fittest,mutate_percent,gen_cross_num,gen_mut_num)];
     endfor  
   initial_population = selection(a,population_limit);
   if (diversity(initial_population)<diversity_threshold)
     d=0;
   endif  
  endwhile 
  fittest_person = fittest;
endfunction

function y = generation(par1,par2,mutate_percent,gen_cross_num,gen_mut_num);
  %% Here par is the selected parent.
  m = size(par1,2);
  y=[par1,par1;par2,par2];
  for i=1:floor(gen_cross_num/2)
    k=[];
    c1 = ceil(m*rand);
    c2 = ceil(m*rand);
    if (c1==0)
      c1=1;
    endif
    if (c2==0)
      c2=1;
    endif
    if (c2<c1)
      t=c1;
      c1 = c2;
      c2 = t;
    endif   
     k = [par1;par2];
     k(:,c1:c2)=[par2(1,c1:c2);par1(1,c1:c2)];
     for j =1:gen_mut_num  
       t=k;
       mut_p = ceil(m*rand); 
       if (mut_p==0)
         mut_p =1;
       endif  
       t(1,mut_p) = t(1,mut_p)*(1+mutate_percent/100*((-1)+2*(rand)));
       mut_p = ceil(m*rand); 
       if (mut_p==0)
         mut_p =1;
       endif  
       t(2,mut_p) = t(2,mut_p)*(1+mutate_percent/100*((-1)+2*(rand)));
       t = [t,[par1;par2]];
       y = [y;t];
     endfor   
  endfor  
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
  su = sum(k)
  fitness_factor = k/su;
  y = 0.25*diversity_factor(A)+fitness_factor;
  %%y = fitness_factor;
endfunction  

function y = selection(A,population_limit)
  m = size(A);
  k = best_factor(A);
  [f,fi] = sort(k);
  if (m(1)>population_limit)
    y = A(fi(m(1):(-1):(m(1)-population_limit+1)),1:(m(2)/2));
  else 
    y = A(:,1:(m(2)/2));
  endif   
endfunction    

function y = fitness(x)
  m = size(x);
  y = e.^-sum(((x-ones(m)).^2),2);
endfunction

function y = diversity(population)
  m = size(population);
  mean = sum(population)/m(1);
  y = sum(sqrt(sum(((population-ones(m(1),1)*mean).^2),2)))/m(1);  
endfunction   
