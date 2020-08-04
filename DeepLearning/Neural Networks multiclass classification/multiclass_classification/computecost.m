function J = computecost(X,theta,y,lambda)
  m = length(y);
  J = (1/m)*sum(-log((ones(size(y,1),1)-y)+(2*y-ones(size(y,1),1)).*sigma(X*theta))) +(lambda/(2*m))*((theta')*theta - theta(1,1)^2) ;
endfunction
