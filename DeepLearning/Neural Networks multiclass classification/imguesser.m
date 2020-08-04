function [z opt_theta] = imguesser(X,y,units_nu_row_matrix,lambda,A,alpha)
  [z opt_theta] = guesser(making_X(X)/255,y,units_nu_row_matrix,lambda,making_X(A)/255,alpha);
endfunction  






