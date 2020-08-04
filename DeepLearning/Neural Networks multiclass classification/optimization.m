function [OptTheta,functionalVal] = optimization(X,y,units_nu_row_matrix,lambda,alpha)
nu_train = size(X,1);
  nu_layers = length(units_nu_row_matrix);
  p(1)=0;
  for i=1:(nu_layers-1)
   p(i+1) = p(i)+(units_nu_row_matrix(i)+1)*(units_nu_row_matrix(i+1));
  endfor  
  
  
  

options = optimset('Gradobj','on','MaxIter',50);
%MaxIter = 100;
initial_theta=1000*rand(p(nu_layers),1);

[OptTheta,functionalVal,exitflag] = fmincg(@(theta)(costfunction(theta,X,y,lambda,units_nu_row_matrix)),initial_theta,options);
%for i = 1:MaxIter
 % [a b] = costfunction(theta,X,y,lambda,units_nu_row_matrix);
 % theta = theta - alpha*b;
 % functionalVal = costfunction(theta,X,y,lambda,units_nu_row_matrix);
 % fprintf('Iteration = %f',i); fprintf(' | cost = %f\n',functionalVal);
  
%endfor  
%OptTheta = theta;
endfunction