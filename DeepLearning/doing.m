





function [jVal,gradient] = costfunction(theta,X,y,lambda)
  m = size(X,1);
  nu_features = size(X,2);
  nu_classes = size(y,2);
  theta1 = reshape(theta(1:(2*nu_features)),nu_features,2);
  theta2 = reshape(theta(((2*nu_features)+1): ((2*nu_features)+(3*nu_classes))),3,nu_classes);
  A{1} = X;
  z{1} = A{1}*theta1;
  A{2} =[ones(m,1),sigma(z{1})];
  z{2} = A{2}*theta2;
  A{3} = z{2};
  jVal =  sum(sum((-log((ones(m,nu_classes)-y)+(2*y-ones(m,nu_classes)).*A{3})),1),2);
  thetader{2} =  (A{2}')*(A{3}-y);
  thetader{1} =   
  
  
endfunction



function y = sigma(x);
  y = 1./(1+e.^(-x));
endfunction
