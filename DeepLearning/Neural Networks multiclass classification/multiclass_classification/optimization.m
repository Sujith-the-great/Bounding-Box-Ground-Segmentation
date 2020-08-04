function [OptTheta,functionalVal,exitflag] = optimization(X,y,lambda)
 
options = optimset('Gradobj','on','MaxIter',50);
initial_theta = rand(size(X,2),1);
[OptTheta,functionalVal,exitflag] = fmincg(@(theta)(costfunction(theta,X,y,lambda)),initial_theta,options);
  
endfunction
