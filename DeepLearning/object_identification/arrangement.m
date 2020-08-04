function[S,y] = arrangement(X,tol)
  x_max = max(X(:,1));
  x_min = min(X(:,1));
  y_max = max(X(:,2));
  y_min = min(X(:,2));
  z_max = max(X(:,3)); 
  z_min = min(X(:,3));
  n_x = floor(x_max-x_min)+1;
  n_y = floor(y_max-y_min)+1;
  n_z = floor(z_max-z_min)+1;
  nu_points = size(X,1);
  y = zeros(n_x,n_y,n_z);
  for i=1:n_x
    for j=1:n_y
      for k=1:n_z
        S{i,j,k}=[];
      endfor
    endfor
  endfor  
  for i=1:nu_points
    k1=1+floor((X(i,1)-x_min)/tol);
    k2=1+floor((X(i,2)-y_min)/tol);
    k3=1+floor((X(i,3)-z_min)/tol);
    S{k1,k2,k3}=[S{k1,k2,k3};X(i,:)];
    y(k1,k2,k3)=y(k1,k2,k3)+1;
  endfor  
endfunction
