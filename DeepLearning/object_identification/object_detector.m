function [y,nu_objects] = object_detector(X,pt_tol,r_width)
  nu_points = size(X,1);
  [fx,fy] = arrangement(X,pt_tol);
  [n_x,n_y,n_z] = size(fy);
  d_surf = [];
  dsq = pt_tol*pt_tol;
  x_min = min(X(:,1))
  y_min = min(X(:,2))
  z_min = min(X(:,3))
  for i=1:n_x
    allotment=0;
    for j=1:n_y
      allotment=0;
      for k=1:n_z
        if(fy(i,j,k)>0)
         p = [(x_min-(pt_tol/2)+i*pt_tol),(y_min-(pt_tol/2)+j*pt_tol),(z_min-(pt_tol/2)+k*pt_tol)];
         allotment=1; 
        endif
      endfor
      if (allotment==1)
        d_surf = [d_surf;p];
      endif 
   endfor
  endfor   
  theta1 = par_the(d_surf)
  theta2 = per_the(d_surf)
  X_sort = (X*[cos(theta1),0,(-sin(theta1));0,1,0;sin(theta1),0,cos(theta1)])*[1,0,0;0,cos(theta2),(-sin(theta2));0,sin(theta2),cos(theta2)];
  [F_x,F_y,X_p] = arrangement(X_sort,pt_tol);
  [N_x,N_y,N_z] = size(F_y);
  k = min(X_sort(:,3)) + r_width;
  y = zeros(size(X,1),1);
  for i=1:nu_points
    nu_objects =1;
    k1 = X_p(i,1); k2 = X_p(i,2) ; k3 = X_p(i,3);   %% shows the grid position of that point i.
    allotment = 0;
    if (X_sort(i,3)<k)
      y(i,1) = 1;    
    else 
      if ((k1!=1)&&(k2!=1)&&(k3!=1))  % down corner  % 1
        for h = 1:size(F_x{k1-1,k2-1,k3-1},1)
          if ((distsqr(F_x{k1-1,k2-1,k3-1}(h,1:3),X_sort(i,:))<=dsq)&&(y(F_x{k1-1,k2-1,k3-1}(h,4),1)>1))
            y(i,1)=y(F_x{k1-1,k2-1,k3-1}(h,4),1);
            allotment = 1;
            break;
          endif
        endfor 
      endif 
      if ((allotment==0)&&((k2!=1)&&(k3!=1))) % 2 
         for h = 1:size(F_x{k1,k2-1,k3-1},1)
          if ((distsqr(F_x{k1,k2-1,k3-1}(h,1:3),X_sort(i,:))<=dsq)&&(y(F_x{k1,k2-1,k3-1}(h,4),1)>1))
            y(i,1)=y(F_x{k1,k2-1,k3-1}(h,4),1);
            allotment = 1;
            break;
          endif
        endfor 
      endif 
      if ((allotment==0)&&((k1!=N_x)&&(k2!=1)&&(k3!=1))) %3 
         for h = 1:size(F_x{k1+1,k2-1,k3-1},1)
          if ((distsqr(F_x{k1+1,k2-1,k3-1}(h,1:3),X_sort(i,:))<=dsq)&&(y(F_x{k1+1,k2-1,k3-1}(h,4),1)>1))
            y(i,1)=y(F_x{k1+1,k2-1,k3-1}(h,4),1);
            allotment = 1;
            break;
          endif
        endfor 
      endif 
      if ((allotment==0)&&((k1!=1)&&(k3!=1)))   %4
         for h = 1:size(F_x{k1-1,k2,k3-1},1)
          if ((distsqr(F_x{k1-1,k2,k3-1}(h,1:3),X_sort(i,:))<=dsq)&&(y(F_x{k1-1,k2,k3-1}(h,4),1)>1))
            y(i,1)=y(F_x{k1-1,k2,k3-1}(h,4),1);
            allotment = 1;
            break;
          endif
        endfor 
      endif 
      if ((allotment==0)&&((k3!=1)))  %5
         for h = 1:size(F_x{k1,k2,k3-1},1)
          if ((distsqr(F_x{k1,k2,k3-1}(h,1:3),X_sort(i,:))<=dsq)&&(y(F_x{k1,k2,k3-1}(h,4),1)>1))
            y(i,1)=y(F_x{k1,k2,k3-1}(h,4),1);
            allotment = 1;
            break;
          endif
        endfor 
      endif 
      if ((allotment==0)&&((k1!=N_x)&&(k3!=1))) %6 
         for h = 1:size(F_x{k1+1,k2,k3-1},1)
          if ((distsqr(F_x{k1+1,k2,k3-1}(h,1:3),X_sort(i,:))<=dsq)&&(y(F_x{k1+1,k2,k3-1}(h,4),1)>1))
            y(i,1)=y(F_x{k1+1,k2,k3-1}(h,4),1);
            allotment = 1;
            break;
          endif
        endfor 
      endif 
      if ((allotment==0)&&((k1!=1)&&(k2!=N_y)&&(k3!=1))) %7  
         for h = 1:size(F_x{k1-1,k2+1,k3-1},1)
          if ((distsqr(F_x{k1-1,k2+1,k3-1}(h,1:3),X_sort(i,:))<=dsq)&&(y(F_x{k1-1,k2+1,k3-1}(h,4),1)>1))
            y(i,1)=y(F_x{k1-1,k2+1,k3-1}(h,4),1);
            allotment = 1;
            break;
          endif
        endfor 
      endif 
      if ((allotment==0)&&((k2!=N_y)&&(k3!=1)))  %8
         for h = 1:size(F_x{k1,k2+1,k3-1},1)
          if ((distsqr(F_x{k1,k2+1,k3-1}(h,1:3),X_sort(i,:))<=dsq)&&(y(F_x{k1,k2+1,k3-1}(h,4),1)>1))
            y(i,1)=y(F_x{k1,k2+1,k3-1}(h,4),1);
            allotment = 1;
            break;
          endif
        endfor 
      endif 
       if ((allotment==0)&&((k1!=N_x)&&(k2!=N_y)&&(k3!=1)))  %9  
         for h = 1:size(F_x{k1+1,k2+1,k3-1},1)
          if ((distsqr(F_x{k1+1,k2+1,k3-1}(h,1:3),X_sort(i,:))<=dsq)&&(y(F_x{k1+1,k2+1,k3-1}(h,4),1)>1))
            y(i,1)=y(F_x{k1+1,k2+1,k3-1}(h,4),1);
            allotment = 1;
            break;
          endif
        endfor 
      endif 
      if ((allotment==0)&&(k1!=1)&&(k2!=1))  % down corner  % 10
        for h = 1:size(F_x{k1-1,k2-1,k3},1)
          if ((distsqr(F_x{k1-1,k2-1,k3}(h,1:3),X_sort(i,:))<=dsq)&&(y(F_x{k1-1,k2-1,k3}(h,4),1)>1))
            y(i,1)=y(F_x{k1-1,k2-1,k3}(h,4),1);
            allotment = 1;
            break;
          endif
        endfor 
      endif 
      if ((allotment==0)&&((k2!=1))) % 11 
         for h = 1:size(F_x{k1,k2-1,k3},1)
          if ((distsqr(F_x{k1,k2-1,k3}(h,1:3),X_sort(i,:))<=dsq)&&(y(F_x{k1,k2-1,k3}(h,4),1)>1))
            y(i,1)=y(F_x{k1,k2-1,k3}(h,4),1);
            allotment = 1;
            break;
          endif
        endfor 
      endif 
      if ((allotment==0)&&((k1!=N_x)&&(k2!=1))) %12 
         for h = 1:size(F_x{k1+1,k2-1,k3},1)
          if ((distsqr(F_x{k1+1,k2-1,k3}(h,1:3),X_sort(i,:))<=dsq)&&(y(F_x{k1+1,k2-1,k3}(h,4),1)>1))
            y(i,1)=y(F_x{k1+1,k2-1,k3}(h,4),1);
            allotment = 1;
            break;
          endif
        endfor 
      endif 
      if ((allotment==0)&&((k1!=1)))   %13
         for h = 1:size(F_x{k1-1,k2,k3},1)
          if ((distsqr(F_x{k1-1,k2,k3}(h,1:3),X_sort(i,:))<=dsq)&&(y(F_x{k1-1,k2,k3}(h,4),1)>1))
            y(i,1)=y(F_x{k1-1,k2,k3}(h,4),1);
            allotment = 1;
            break;
          endif
        endfor 
      endif 
      if ((allotment==0))  %14
         for h = 1:size(F_x{k1,k2,k3},1)
          if (((distsqr(F_x{k1,k2,k3}(h,1:3),X_sort(i,:))<=dsq)&&(y(F_x{k1,k2,k3}(h,4),1)>1))&&(F_x{k1,k2,k3}(h,4)!=i))
            y(i,1)=y(F_x{k1,k2,k3}(h,4),1);
            allotment = 1;
            break;
          endif
        endfor 
      endif 
      if ((allotment==0)&&((k1!=N_x))) %15 
         for h = 1:size(F_x{k1+1,k2,k3},1)
          if ((distsqr(F_x{k1+1,k2,k3}(h,1:3),X_sort(i,:))<=dsq)&&(y(F_x{k1+1,k2,k3}(h,4),1)>1))
            y(i,1)=y(F_x{k1+1,k2,k3}(h,4),1);
            allotment = 1;
            break;
          endif
        endfor 
      endif 
      if ((allotment==0)&&((k1!=1)&&(k2!=N_y))) %16  
         for h = 1:size(F_x{k1-1,k2+1,k3},1)
          if ((distsqr(F_x{k1-1,k2+1,k3}(h,1:3),X_sort(i,:))<=dsq)&&(y(F_x{k1-1,k2+1,k3}(h,4),1)>1))
            y(i,1)=y(F_x{k1-1,k2+1,k3}(h,4),1);
            allotment = 1;
            break;
          endif
        endfor 
      endif 
      if ((allotment==0)&&((k2!=N_y)))  %17
         for h = 1:size(F_x{k1,k2+1,k3},1)
          if ((distsqr(F_x{k1,k2+1,k3}(h,1:3),X_sort(i,:))<=dsq)&&(y(F_x{k1,k2+1,k3}(h,4),1)>1))
            y(i,1)=y(F_x{k1,k2+1,k3}(h,4),1);
            allotment = 1;
            break;
          endif
        endfor 
      endif 
       if ((allotment==0)&&((k1!=N_x)&&(k2!=N_y)))  %18  
         for h = 1:size(F_x{k1+1,k2+1,k3},1)
          if ((distsqr(F_x{k1+1,k2+1,k3}(h,1:3),X_sort(i,:))<=dsq)&&(y(F_x{k1+1,k2+1,k3}(h,4),1)>1))
            y(i,1)=y(F_x{k1+1,k2+1,k3}(h,4),1);
            allotment = 1;
            break;
          endif
        endfor 
      endif 
      if ((allotment==0)&&(k1!=1)&&(k2!=1)&&(k3!=N_z))  % down corner  % 19
        for h = 1:size(F_x{k1-1,k2-1,k3+1},1)
          if ((distsqr(F_x{k1-1,k2-1,k3+1}(h,1:3),X_sort(i,:))<=dsq)&&(y(F_x{k1-1,k2-1,k3+1}(h,4),1)>1))
            y(i,1)=y(F_x{k1-1,k2-1,k3+1}(h,4),1);
            allotment = 1;
            break;
          endif
        endfor 
      endif 
      if ((allotment==0)&&((k2!=1)&&(k3!=N_z))) % 20 
         for h = 1:size(F_x{k1,k2-1,k3+1},1)
          if ((distsqr(F_x{k1,k2-1,k3+1}(h,1:3),X_sort(i,:))<=dsq)&&(y(F_x{k1,k2-1,k3+1}(h,4),1)>1))
            y(i,1)=y(F_x{k1,k2-1,k3+1}(h,4),1);
            allotment = 1;
            break;
          endif
        endfor 
      endif 
      if ((allotment==0)&&((k1!=N_x)&&(k2!=1)&&(k3!=N_z))) %21 
         for h = 1:size(F_x{k1+1,k2-1,k3+1},1)
          if ((distsqr(F_x{k1+1,k2-1,k3+1}(h,1:3),X_sort(i,:))<=dsq)&&(y(F_x{k1+1,k2-1,k3+1}(h,4),1)>1))
            y(i,1)=y(F_x{k1+1,k2-1,k3+1}(h,4),1);
            allotment = 1;
            break;
          endif
        endfor 
      endif 
      if ((allotment==0)&&((k1!=1)&&(k3!=N_z)))   %22
         for h = 1:size(F_x{k1-1,k2,k3+1},1)
          if ((distsqr(F_x{k1-1,k2,k3+1}(h,1:3),X_sort(i,:))<=dsq)&&(y(F_x{k1-1,k2,k3+1}(h,4),1)>1))
            y(i,1)=y(F_x{k1-1,k2,k3+1}(h,4),1);
            allotment = 1;
            break;
          endif
        endfor 
      endif 
      if ((allotment==0)&&((k3!=N_z)))  %23
         for h = 1:size(F_x{k1,k2,k3+1},1)
          if ((distsqr(F_x{k1,k2,k3+1}(h,1:3),X_sort(i,:))<=dsq)&&(y(F_x{k1,k2,k3+1}(h,4),1)>1))
            y(i,1)=y(F_x{k1,k2,k3+1}(h,4),1);
            allotment = 1;
            break;
          endif
        endfor 
      endif 
      if ((allotment==0)&&((k1!=N_x)&&(k3!=N_z))) %24 
         for h = 1:size(F_x{k1+1,k2,k3+1},1)
          if ((distsqr(F_x{k1+1,k2,k3+1}(h,1:3),X_sort(i,:))<=dsq)&&(y(F_x{k1+1,k2,k3+1}(h,4),1)>1))
            y(i,1)=y(F_x{k1+1,k2,k3+1}(h,4),1);
            allotment = 1;
            break;
          endif
        endfor 
      endif 
      if ((allotment==0)&&((k1!=1)&&(k2!=N_y)&&(k3!=N_z))) %25  
         for h = 1:size(F_x{k1-1,k2+1,k3+1},1)
          if ((distsqr(F_x{k1-1,k2+1,k3+1}(h,1:3),X_sort(i,:))<=dsq)&&(y(F_x{k1-1,k2+1,k3+1}(h,4),1)>1))
            y(i,1)=y(F_x{k1-1,k2+1,k3+1}(h,4),1);
            allotment = 1;
            break;
          endif
        endfor 
      endif 
      if ((allotment==0)&&((k2!=N_y)&&(k3!=N_z)))  %26
         for h = 1:size(F_x{k1,k2+1,k3+1},1)
          if ((distsqr(F_x{k1,k2+1,k3+1}(h,1:3),X_sort(i,:))<=dsq)&&(y(F_x{k1,k2+1,k3+1}(h,4),1)>1))
            y(i,1)=y(F_x{k1,k2+1,k3+1}(h,4),1);
            allotment = 1;
            break;
          endif
        endfor 
      endif 
      if ((allotment==0)&&((k1!=N_x)&&(k2!=N_y)&&(k3!=N_z)))  %27
        for h = 1:size(F_x{k1+1,k2+1,k3+1},1)
          if ((distsqr(F_x{k1+1,k2+1,k3+1}(h,1:3),X_sort(i,:))<=dsq)&&(y(F_x{k1+1,k2+1,k3+1}(h,4),1)>1))
            y(i,1)=y(F_x{k1+1,k2+1,k3+1}(h,4),1);
            allotment = 1;
            break;
          endif
        endfor 
      endif
      if (allotment == 0)
        nu_objects = nu_objects+1;
        y(i,1) = nu_objects;
      endif 
    endif 
  endfor   
 
  
  
  
  
endfunction

function theta = par_the(d)
  x = [d(:,1),d(:,3)];
  [a,b] = min(d(:,3));
  pt = [d(b,1),d(b,3)]; 
  ang = 0;
  acc_t = acc(x,pt,(ang+1)*(pi/180));
  acc_m = acc(x,pt,ang*pi/180);
  acc_b = acc(x,pt,(ang-1)*(pi/180));
  p=4;
  while(p==4)
    if (acc_m==acc_t)
      ang = (ang + 1);
      acc_b = acc_m;
      acc_m = acc_t;
      acc_t = acc(x,pt,((ang+1)*pi/180));      
    elseif ((acc_b<acc_m)&&(acc_m<acc_t))
      ang = (ang + 1);
      acc_b = acc_m;
      acc_m = acc_t;
      acc_t = acc(x,pt,((ang+1)*pi/180));  
     elseif((acc_b>acc_m)&&(acc_m>acc_t))
      ang = ang - 1;
      acc_t = acc_m;
      acc_m = acc_b;
      acc_b = acc(x,pt,(ang -1)* (pi/180));
     else
      p=5;
    endif      
  endwhile 
  p=6;acc_t = acc(x,pt,(ang+1)*(pi/1800));
  acc_m = acc(x,pt,ang*pi/180);
  acc_b = acc(x,pt,(ang-1)*(pi/1800));
  while(p==6)
    if((acc_b<acc_m)&&(acc_m<acc_t))
      ang = ang +1;
      acc_b = acc_m;
      acc_m = acc_t;
      acc_t = acc(x,pt,(ang+1)*(pi/1800));
    elseif((acc_b>acc_m)&&(acc_m>acc_t))
      ang = ang -1;
      acc_t = acc_m;
      acc_m = acc_b;
      acc_b = acc(x,pt,(ang -1)* (pi/1800));
    else
      p=5;
    endif      
  endwhile 
  theta = ang*pi/180;
endfunction 
function theta = per_the(d)
  x = [d(:,2),d(:,3)];
  [a,b] = min(d(:,3));
  pt = [d(b,2),d(b,3)]; 
  theta = 0;
  acc_t = acc(x,pt,theta+(pi/180));
  acc_m = acc(x,pt,theta);
  acc_b = acc(x,pt,theta-(pi/180));
  p=4;
  while(p==4)
    if((acc_b<acc_m)&&(acc_m<acc_t))
      theta = theta + (pi/180);
      acc_b = acc_m;
      acc_m = acc_t;
      acc_t = acc(x,pt,theta+(pi/180));
    elseif((acc_b>acc_m)&&(acc_m>acc_t))
      theta = theta - (pi/180);
      acc_t = acc_m;
      acc_m = acc_b;
      acc_b = acc(x,pt,theta - (pi/180));
    else
      p=5;
    endif      
  endwhile
  p=6;acc_t = acc(x,pt,theta+(pi/1800));
  acc_m = acc(x,pt,theta);
  acc_b = acc(x,pt,theta-(pi/1800));
  while(p==6)
    if((acc_b<acc_m)&&(acc_m<acc_t))
      theta = theta + (pi/1800);
      acc_b = acc_m;
      acc_m = acc_t;
      acc_t = acc(x,pt,theta+(pi/1800));
    elseif((acc_b>acc_m)&&(acc_m>acc_t))
      theta = theta - (pi/1800);
      acc_t = acc_m;
      acc_m = acc_b;
      acc_b = acc(x,pt,theta - (pi/1800));
    else
      p=5;
    endif      
  endwhile  
  
endfunction 

function y = acc(d,pt,ang)
  m= size(d,1);
  y = sum(((d-(ones(m,1)*pt))*[-sin(ang);cos(ang)])>=0)/m;
endfunction







function[S,y,X_p] = arrangement(X,tol)
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
  X_p = zeros(size(X));
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
    S{k1,k2,k3}=[S{k1,k2,k3};X(i,:),i];
    y(k1,k2,k3)=y(k1,k2,k3)+1;
    X_p(i,:) = [k1,k2,k3];
  endfor  
endfunction
function y = distsqr(a,b)
  y = (a-b)*((a-b)');  
endfunction
