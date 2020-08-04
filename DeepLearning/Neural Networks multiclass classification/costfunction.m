function [jVal,gradient] = costfunction(theta,X,y,lambda,units_nu_row_matrix)
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
  z{1} =  X;
  for i=1:(nu_layers-2)
    z{i+1} = A{i}*thetacell{i} ;
    A{i+1} = [ones(nu_train,1),sigma(z{i+1})];
    k = k + sum(sum(thetacell{i}.^2,1),2) - sum(thetacell{i}(1,:).^2);
  endfor
  z{nu_layers} = A{(nu_layers-1)}*thetacell{(nu_layers-1)};
  A{nu_layers} = sigma(z{nu_layers});
  k = k + sum(sum(thetacell{nu_layers-1}.^2,1),2) - sum(thetacell{nu_layers-1}(1,:).^2);
  jVal =  (1/nu_train)*sum(sum((-log((ones(size(y))-y)+((2*y-ones(size(y))).*A{nu_layers}))),1),2) + (lambda/(2*nu_train))*k;  

   %% let thetadercell be derivatives of jVal of matrices of theta. 
   thetadercell = thetacell;
   delta_A = A;
   delta_z = z;
   delta_z{nu_layers} = A{nu_layers}-y;
 
       for i=2:(nu_layers-1)
         thetadercell{nu_layers+1-i} = (1/nu_train)*((A{nu_layers+1-i}')*delta_z{nu_layers+2-i} + (lambda)*[zeros(1,size(thetacell{nu_layers+1-i},2));thetacell{nu_layers+1-i}((2:end),:)]);
         delta_A{nu_layers+1-i} = delta_z{nu_layers+2-i}*(thetacell{nu_layers+1-i}');
         delta_z{nu_layers+1-i} = delta_A{nu_layers+1-i}(:,(2:end)).*((sigma(z{nu_layers+1-i})).*(ones(size(z{nu_layers+1-i}))-sigma(z{nu_layers+1-i})));
       endfor
       thetadercell{1} = (1/nu_train)*((A{1}')*delta_z{2} + (lambda)*[zeros(1,size(thetacell{1},2));thetacell{1}((2:end),:)]);
     
   
   
 for i=1:(nu_layers-1)
   for j=(p(i)+1):p(i+1)
     gradient(j,1) = (reshape(thetadercell{i},(size(thetadercell{i},1)*size(thetadercell{i},2)),1))((j-p(i)),1);
   endfor
 endfor  
endfunction