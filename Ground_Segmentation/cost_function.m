
function [y,gradient] = cost_function(A,theta)
  %% A is a coordinate matrix with size m*3 and theta is a 1*3 vector.
  m = size(A,1);
  k = A*(theta)-ones(m,1);
  t = theta'*theta; 
  y = (1/(2*m))*((k')*k)/t;
  gradient = (1/m)*((((A')*k)/t))-(2*((y*theta)/(t)));
endfunction