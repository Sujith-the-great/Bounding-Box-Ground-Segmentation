function [jVal,gradient] = costfunction_my(theta,X,y,lambda,units_nu_row_matrix)
  nu_train = size(X,1);
  nu_layers = length(units_nu_row_matrix);
  p(1)=0;
  for i=1:(nu_layers-1)
   p(i+1) = p(i)+(units_nu_row_matrix(i)+1)*(units_nu_row_matrix(i+1));
  endfor 
  %%  Making thetacell
  for i=1:(nu_layers-1)
    thetacell{i} = reshape(theta((p(i)+1):p(i+1)),(units_nu_row_matrix(i)+1),units_nu_row_matrix(i+1));
  endfor
  k=0;
  %% Let A be a activation cell containing row matrices of layers.
  A{1} =  X;     
  for i=1:(nu_layers-2)
    A{i+1} = [ones(nu_train,1),sigma(A{i}*thetacell{i})];
    z{i} = A{i}*thetacell{i} ;
    k = k + sum(sum(thetacell{i}.^2,1),2) - sum(thetacell{i}(1,:).^2);
  endfor
  A{nu_layers} = sigma(A{(nu_layers-1)}*thetacell{(nu_layers-1)});
  z{nu_layers-1} = A{(nu_layers-1)}*thetacell{(nu_layers-1)};
  jVal =  (1/nu_train)*sum(sum((-log((ones(size(y,1),size(y,2))-y)+((2*y-ones(size(y,1),size(y,2))).*A{nu_layers}))),1),2) + (lambda/(2*nu_train))*k  ;
  
  %% let thetadercell be derivatives of jVal of matrices of theta. 
   thetadercell = thetacell;
   for i=(nu_layers-1):(-1):1
     for j=1:size(thetacell{i},1)
       for k=1:size(thetacell{i},2)
         if j==1
           thetadercell{i}(j,k) = (1/nu_train)*sum(sum(qrep((A{i}*mat(j,k,size(thetacell{i},1),size(thetacell{i},2))),i,nu_layers,A,thetacell,y,z),1),2);           
         else  
         thetadercell{i}(j,k) = (1/nu_train)*sum(sum(qrep((A{i}*mat(j,k,size(thetacell{i},1),size(thetacell{i},2))),i,nu_layers,A,thetacell,y,z),1),2) + (lambda/nu_train)*thetacell{i}(j,k)  ;
         endif 
       endfor
     endfor  
   endfor
 for i=1:(nu_layers-1)
   for j=(p(i)+1):p(i+1)
     gradient(j,1) = (reshape(thetadercell{i},(size(thetadercell{i},1)*size(thetadercell{i},2)),1))((j-p(i)),1);
   endfor
 endfor  
endfunction



function ans = qrep(x,a,nu_layers,A,thetacell,y,z)
  if a==nu_layers-1
    ans = (A{nu_layers}-y).*(x);
  endif
  if (a<(nu_layers-1))
    new_x =([zeros(size(((gder(z{a})).*(x)),1),1),((gder(z{a})).*(x))]*thetacell{a+1});
    ans = qrep(new_x,a+1,nu_layers,A,thetacell,y,z);
  endif
endfunction  



function y = gder(x)
  y = (e.^(-x))./((1+(e.^(-x))).^2);
endfunction

function y = mat(i,j,a,b)
  y= zeros(a,b);
  y(i,j)=1;
endfunction  
