function [p,a] = guesser(train,y,lambda,tester)
  m = length(y);
  n = length(tester);
  for i=1:m
    X(i,:) = [1,feature_matrix(strvcat(train(i,1)))];
  endfor
  
  for i=1:n
    A(i,:) = [1,feature_matrix(strvcat(tester(i,1)))];
  endfor
 [a k] = multiclass(X,y,lambda,A);
 p=k'
 
endfunction
