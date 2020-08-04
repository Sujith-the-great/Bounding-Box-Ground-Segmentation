function [jVal, gradient] = costfunction(theta,X,y,lambda)
  m = length(y);
   jVal = computecost(X,theta,y,lambda);
   gradient = (1/m)*((X')*(sigma(X*theta )- y))+(lambda/m)*(theta-[theta(1,1);zeros(size(theta,1)-1,1)]);
 endfunction