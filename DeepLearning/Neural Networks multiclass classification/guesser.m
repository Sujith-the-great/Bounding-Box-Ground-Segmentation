function [z opt_theta] = guesser(X,y,units_nu_row_matrix,lambda,A,alpha)
  [a opt_theta] = probable(X,y,units_nu_row_matrix,lambda,A,alpha);
  z=a; 
 % if units_nu_row_matrix(length(units_nu_row_matrix))>1   
  %   z=zeros(size(a,1),size(a,2));
   %q = max(a,[],2);     % index matrix
  % for i=1:size(a,1);
   %  z(i,q(i,1))=1;
  % endfor
 % else (z=zeros(size(a,1),1);
  % for i=1:size(a,1)
   %  if z(i,1)<0.5
    %   z(i,1)=0;
    %  else z(i,1)=1;
   %  endif
  % endfor)
 % endif 
endfunction
