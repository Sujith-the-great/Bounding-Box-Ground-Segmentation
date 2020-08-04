function [centre,theta,cost,sign,dist_vector] = dimensionality(A,initial_theta)
  m = size(A,1);
  sign = 1;
  theta = optimization(A,initial_theta);
  image = A-(((A*theta)-ones(m,1))/(theta'*theta))*(theta');
  
  centre = mean(image,1);
 
  if (theta(3)<0)
    theta=-theta; sign = -1;
  elseif (theta(3)==0)
    if (theta(2)<0)
    theta=-theta; sign = -1;
    elseif (theta(2)==0)
      if (theta(1)<0) 
        theta=-theta; sign = -1;
      endif
    endif 
  endif
   dist_vector = sqrt(theta'*theta)*(sum((A-image),2)/sum(theta));
   cost = (1/m)*sum(modu(dist_vector));
endfunction


function [y,gradient] = cost_function(A,theta)
  %% A is a coordinate matrix with size m*3 and theta is a 1*3 vector.
  m = size(A,1);
  k = A*(theta)-ones(m,1);
  t = theta'*theta; 
  y = (1/(2*m))*((k')*k)/t;
  gradient = (1/m)*((((A')*k)/t))-(2*((y*theta)/(t)));
endfunction

function OptTheta = optimization(A,initial_theta)
  options = optimset('Gradobj','on','MaxIter',200);  
  [OptTheta,functionalVal,exitflag] = fmincg(@(theta)(cost_function(A,theta)),initial_theta,options);
endfunction

function y = modu(x)
  y=((-(x<0)).*x)+((x>=0).*x);
endfunction
