function [length,breadth,height,theta,centre]= box(X)
  [maxi,imax]=max(X);
  [mini,imin]=min(X);
  kp =maxi-mini;
  %length=k(1,1);
  %breadth=k(1,2);
  height=kp(1,3);
  %centre = [(X(imax(1,1),1)+X(imin(1,1),1))/2,(X(imax(1,2),2)+X(imin(1,2),2))/2,(X(imax(1,3),3)+X(imin(1,3),3))/2];
  centre(1,3)=(X(imax(1,3),3)+X(imin(1,3),3))/2;
  x1=X(imin(1,1),:)
  x2=X(imin(1,2),:)
  x3=X(imax(1,2),:)
  x4=X(imax(1,1),:)
   g =((x1(1,2)-x2(1,2))*X(:,1))+((x2(1,1)-x1(1,1))*X(:,2))+(ones(size(X,1),1)*(x2(1,2)*x1(1,1)-x2(1,1)*x1(1,2))); 
   [dmin,idmin]= min(g);
    dmin=dmin/sqrt((x1(1,2)-x2(1,2))*((x1(1,2)-x2(1,2))')+(x2(1,1)-x1(1,1))*((x2(1,1)-x1(1,1))'));
   theta = atan(-((x1(1,2)-x2(1,2))/(x1(1,1)-x2(1,1))));
   if (dmin<0)
     p =(x1(1,1:2)+x2(1,1:2))/2;
     k = [p(1,1)+dmin*sin(theta),p(1,2)+dmin*cos(theta)];
     else
     k = (x1(1,1:2)+x2(1,1:2))/2;dmin=0;
    endif
  [dmax,idmax]=max(g);
  dmax=dmax/sqrt((x1(1,2)-x2(1,2))*((x1(1,2)-x2(1,2))')+(x2(1,1)-x1(1,1))*((x2(1,1)-x1(1,1))'));
  length = dmax-dmin;
  dmin
  dmax
 
 
  theta2 =pi/2 - theta;
  h = -(((x1(1,2)-x3(1,2))*X(:,1))+((x3(1,1)-x1(1,1))*X(:,2))+ones(size(X,1),1)*(x3(1,2)*x1(1,1)-x3(1,1)*x1(1,2))) ;
  [kmin,ikmin]=min(h);
  kmin=kmin/sqrt((x1(1,2)-x3(1,2))*((x1(1,2)-x3(1,2))')+(x3(1,1)-x1(1,1))*((x3(1,1)-x1(1,1))'));
  if (kmin<0)
    t =(x1(1,1:2)+x3(1,1:2))/2
      l = [t(1,1)+kmin*sin(theta2),t(1,2)-kmin*cos(theta2)];
     else
     l = (x1(1,1:2)+x3(1,1:2))/2;kmin=0;
  endif
  [kmax,ikmax]=max(h);
  kmax=kmax/sqrt((x1(1,2)-x3(1,2))*((x1(1,2)-x3(1,2))')+(x3(1,1)-x1(1,1))*((x3(1,1)-x1(1,1))'));
  breadth = kmax-kmin;
  lambda = (k(1,1)-l(1,1))*cos(theta2)+(k(1,2)-l(1,2))*sin(theta2)+(length/2)*(sin(theta)*cos(theta2)+sin(theta2)*cos(theta))/(sin(theta)*cos(theta2)+sin(theta2)*cos(theta) );
  centre(1,1:2)= l+(breadth/2)*[sin(theta2),-cos(theta2)]+lambda*[sin(theta),cos(theta)];
  theta = pi/2 - theta;
  
  
endfunction