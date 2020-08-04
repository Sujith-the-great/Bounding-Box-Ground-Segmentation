function [OptTheta,cost] = optimization(A,initial_theta)
  options = optimset('Gradobj','on','MaxIter',50);  
  [OptTheta,functionalVal,exitflag] = fmincg(@(theta)(cost_function(A,theta)),initial_theta,options);
  cost =  cost_function(A,OptTheta); 
endfunction

