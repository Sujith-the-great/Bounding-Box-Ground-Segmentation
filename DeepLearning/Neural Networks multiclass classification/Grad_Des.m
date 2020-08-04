function opt_theta = Grad_Des(X,y,units_nu_row_matrix,alpha,Max_Iter)
  nu_train = size(X,1);
  nu_layers = length(units_nu_row_matrix);
  p(1)=0;
  for i=1:(nu_layers-1)
   p(i+1) = p(i)+(units_nu_row_matrix(i)+1)*(units_nu_row_matrix(i+1));
  endfor  
  opt_theta = rand(p(nu_layers),1);
  for i= 1:Max_Iter
    [a b] = costfunction(opt_theta,X,y,units_nu_row_matrix);
    opt_theta = opt_theta -  (alpha)*b;   
  endfor
endfunction
