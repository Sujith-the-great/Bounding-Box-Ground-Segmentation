function [q cost opt_theta] = probable(X,y,units_nu_row_matrix,lambda,A,alpha)
  [theta b] = optimization(X,y,units_nu_row_matrix,lambda,alpha);
   nu_train = size(X,1);
   cost = b;
  nu_layers = length(units_nu_row_matrix);
  p(1)=0;
  for i=1:(nu_layers-1)
   p(i+1) = p(i)+(units_nu_row_matrix(i)+1)*(units_nu_row_matrix(i+1));
  endfor 
  %%  Making thetacell
  for i=1:(nu_layers-1)
    thetacell{i} = reshape(theta((p(i)+1):p(i+1)),(units_nu_row_matrix(i)+1),units_nu_row_matrix(i+1));
  endfor
  nu_tester = size(A,1);
  %% Let B be a activation cell containing row matrices of layers.
  B{1} =  A;     
  for i=1:(nu_layers-2)
    B{i+1} = [ones(nu_tester,1),sigma(B{i}*thetacell{i})];
    z{i} = B{i}*thetacell{i} ;
  endfor
  B{nu_layers} = sigma(B{(nu_layers-1)}*thetacell{(nu_layers-1)});
  z{nu_layers-1} = B{(nu_layers-1)}*thetacell{(nu_layers-1)};
  q = B{nu_layers};
  opt_theta=theta;
  
endfunction
