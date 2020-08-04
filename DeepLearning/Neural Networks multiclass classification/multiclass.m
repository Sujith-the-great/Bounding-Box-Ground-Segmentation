function [A,thetacell]  = multiclass(X,y,units_nu_row_matrix)
  %% units_nu_row_matrix = displays row vector of number of units in each layer
  nu_layers = length(units_nu_row_matrix);
  nu_train = size(X,1);
  %% nu_layers = number of layers in the neural network
  %% Let A be a activation cell containing row matrices of layers
  for i=2:(nu_layers-1)
    A{i} = zeros(nu_train,(1+units_nu_row_matrix(1,i)));
  endfor
 A{1} =  X;
 A{nu_layers} = zeros(nu_train,(units_nu_row_matrix(1,nu_layers)));
 %% thetacell = the cell containing matrices of all theta.
 for i=1:(nu_layers-1)
   thetacell{i} = zeros((units_nu_row_matrix(1,i)+1),units_nu_row_matrix(1,(i+1)));
 endfor  
  
  
  
  
  
endfunction
