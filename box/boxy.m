function [length,breadth,height,angle,centre]=boxy(X,threshold,number)
  [maxi,imax]=max(X);
  [mini,imin]=min(X);
   x1=X(imin(1,1),:);
   c=(sum(sqrt(sum((X-ones(size(X,1),1)*x1).^2,2))<=threshold)<number);
  while  (c==1)
    X=[X(1:imin(1,1)-1,:);X(imin(1,1)+1:size(X,1),:)];
    [maxi,imax]=max(X);
    [mini,imin]=min(X);
    x1=X(imin(1,1),:);
    c=(sum(sqrt(sum((X-ones(size(X,1),1)*x1).^2,2))<=threshold)<number);
  endwhile  
  x2=X(imax(1,1),:);
  c=(sum(sqrt(sum((X-ones(size(X,1),1)*x2).^2,2))<=threshold)<number);
  while  (c==1)
    X=[X(1:imax(1,1)-1,:);X(imax(1,1)+1:size(X,1),:)];
    [maxi,imax]=max(X);
    [mini,imin]=min(X);
    x2=X(imax(1,1),:);
    c=(sum(sqrt(sum((X-ones(size(X,1),1)*x2).^2,2))<=threshold)<number);
  endwhile  
  x1
  x2
  bo = line(X,x1,x2,threshold);
  if(bo==1||bo==3)
       x3=X(imax(1,2),:);
       c=(sum(sqrt(sum((X-ones(size(X,1),1)*x3).^2,2))<=threshold)<number);
       while  (c==1)
        X=[X(1:imax(1,2)-1,:);X(imax(1,2)+1:size(X,1),:)];
        [maxi,imax]=max(X);
        [mini,imin]=min(X);
         x3=X(imax(1,2),:);
        c=(sum(sqrt(sum((X-ones(size(X,1),1)*x3).^2,2))<=threshold)<number);
       endwhile
     if(bo==1)  
       g=((x2(1,1)-x1(1,1))*X(:,2)+(x1(1,2)-x2(1,2))*X(:,1)+ones(size(X,1),1)*(x1(1,1)*x2(1,2)-x2(1,1)*x1(1,2)))/sqrt(((x2(1,1)-x1(1,1))*(x2(1,1)-x1(1,1))')+((x1(1,2)-x2(1,2))*(x1(1,2)-x2(1,2))')); 
       [dmin,idmin]=min(g);
       theta=atan(((x2(1,2)-x1(1,2)))/(x2(1,1)-x1(1,1)));
       d = X(idmin,:);
       c=(sum(sqrt(sum((X-ones(size(X,1),1)*d).^2,2))<=threshold)<number);
       while  (c==1)
        X=[X(1:idmin-1,:);X(idmin+1:size(X,1),:)];
        g=((x2(1,1)-x1(1,1))*X(:,2)+(x1(1,2)-x2(1,2))*X(:,1)+ones(size(X,1),1)*(x1(1,1)*x2(1,2)-x2(1,1)*x1(1,2)))/sqrt(((x2(1,1)-x1(1,1))*(x2(1,1)-x1(1,1))')+((x1(1,2)-x2(1,2))*(x1(1,2)-x2(1,2))')); 
       [dmin,idmin]= min(g);
       d = X(idmin,:);
       c=(sum(sqrt(sum((X-ones(size(X,1),1)*d).^2,2))<=threshold)<number);
       endwhile  
       if (dmin<0)
       p =(x1(1,1:2)+x2(1,1:2))/2;
       k = [p(1,1)-dmin*sin(theta),p(1,2)+dmin*cos(theta)];
       else
       k = (x1(1,1:2)+x2(1,1:2))/2;dmin=0;
       endif
       [dmax,idmax]=max(g);
       d = X(idmax,:);
       c=(sum(sqrt(sum((X-ones(size(X,1),1)*d).^2,2))<=threshold)<number);
       while  (c==1)
       X=[X(1:idmax-1,:);X(idmax+1:size(X,1),:)];
       g=((x2(1,1)-x1(1,1))*X(:,2)+(x1(1,2)-x2(1,2))*X(:,1)+ones(size(X,1),1)*(x1(1,1)*x2(1,2)-x2(1,1)*x1(1,2)))/sqrt(((x2(1,1)-x1(1,1))*(x2(1,1)-x1(1,1))')+((x1(1,2)-x2(1,2))*(x1(1,2)-x2(1,2))'));      
       [dmax,idmax]= max(g);
       d = X(idmax,:);
       c=(sum(sqrt(sum((X-ones(size(X,1),1)*d).^2,2))<=threshold)<number);
       endwhile
       length = dmax-dmin;
       h=   ((x2(1,1)-x3(1,1))*X(:,2)+(x3(1,2)-x2(1,2))*X(:,1)+ones(size(X,1),1)*(x3(1,1)*x2(1,2)-x2(1,1)*x3(1,2)))/sqrt(((x2(1,1)-x3(1,1))*(x2(1,1)-x3(1,1))')+((x3(1,2)-x2(1,2))*(x3(1,2)-x2(1,2))'));
       [kmax,ikmax]=max(h);
       d=X(ikmax,:);
       c=(sum(sqrt(sum((X-ones(size(X,1),1)*d).^2,2))<=threshold)<number);
       while  (c==1)
       X=[X(1:idmax-1,:);X(idmax+1:size(X,1),:)];
        h=   ((x2(1,1)-x3(1,1))*X(:,2)+(x3(1,2)-x2(1,2))*X(:,1)+ones(size(X,1),1)*(x3(1,1)*x2(1,2)-x2(1,1)*x3(1,2)))/sqrt(((x2(1,1)-x3(1,1))*(x2(1,1)-x3(1,1))')+((x3(1,2)-x2(1,2))*(x3(1,2)-x2(1,2))'));
       [kmax,ikmax]=max(h);
       d=X(ikmax,:);
       c=(sum(sqrt(sum((X-ones(size(X,1),1)*d).^2,2))<=threshold)<number);
       endwhile
       
       if (kmax>0)
        t =(x1(1,1:2)+x3(1,1:2))/2;
        l = [t(1,1)+kmax*cos(theta),t(1,2)+kmax*sin(theta)];
       else
        l = (x1(1,1:2)+x3(1,1:2))/2;kmax=0;
       endif
       [kmin,ikmin]=min(h);
       d = X(ikmin,:);
       c=(sum(sqrt(sum((X-ones(size(X,1),1)*d).^2,2))<=threshold)<number);
       while  (c==1)
        X=[X(1:ikmin-1,:);X(ikmin+1:size(X,1),:)];
        h=   ((x2(1,1)-x3(1,1))*X(:,2)+(x3(1,2)-x2(1,2))*X(:,1)+ones(size(X,1),1)*(x3(1,1)*x2(1,2)-x2(1,1)*x3(1,2)))/sqrt(((x2(1,1)-x3(1,1))*(x2(1,1)-x3(1,1))')+((x3(1,2)-x2(1,2))*(x3(1,2)-x2(1,2))'));
        [kmin,ikmin]=min(h);
        d=X(ikmin,:);
        c=(sum(sqrt(sum((X-ones(size(X,1),1)*d).^2,2))<=threshold)<number);
       endwhile  
       breadth = kmax-kmin;
       lambda = -((length/2)+(k(1,1)-l(1,1))*cos(theta)+(k(1,2)-l(1,2))*sin(theta)  );
       centre(1,1:2)= k+(breadth/2)*[-sin(theta),cos(theta)]-lambda*[cos(theta),sin(theta)];
       angle=theta;       
     else
     endif 
  else
  
  endif
  
  
  
  
  
  
endfunction
function c = line(X,x1,x2,threshold)
  num_abo_lin =   sum((((x2(1,1)-x1(1,1))*X(:,2)+(x1(1,2)-x2(1,2))*X(:,1)+ones(size(X,1),1)*(x1(1,1)*x2(1,2)-x2(1,1)*x1(1,2)))>0));
  num_bel_lin =   sum((((x2(1,1)-x1(1,1))*X(:,2)+(x1(1,2)-x2(1,2))*X(:,1)+ones(size(X,1),1)*(x1(1,1)*x2(1,2)-x2(1,1)*x1(1,2)))<0));
  if (num_abo_lin>num_bel_lin)
    if(comp_lin(X,x1,x2,threshold)==1)
     c=1;
    else 
     c=3;
    endif 
  else
    if (comp_lin(X,x1,x2,threshold)==1)
      c=4;
    else
      c=2;
    endif  
  endif   
endfunction
function c = comp_lin(X,x1,x2,threshold)
  c=0;
  for(i=[0:1:10])
    x=x1+(x2-x1)*i/10;
           if sum(sqrt(sum(((X-ones(size(X,1),1)*x).^2),2))<threshold)>4
             c=c+1;
           endif 
  endfor
  if c>=8
    c=1;
  else 
    c=0;
  endif  
endfunction  
function c=inQ1(x)
  if ((x(1,1)>0)&&(x(1,2)>0))
    c=1;
  else
    c=0;
  endif
endfunction
function c=inQ2(x)
  if ((x(1,1)<0)&&(x(1,2)>0))
    c=1;
  else
    c=0;
  endif
endfunction
function c=inQ3(x)
  if ((x(1,1)<0)&&(x(1,2)<0))
    c=1;
  else
    c=0;
  endif
endfunction
function c=inQ4(x)
  if ((x(1,1)>0)&&(x(1,2)<0))
    c=1;
  else
    c=0;
  endif
endfunction

