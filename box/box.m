function [length,breadth,height,theta,centre]= box(X,threshold,number)
  [maxi,imax]=max(X);
  [mini,imin]=min(X);
  %length=k(1,1);
  %breadth=k(1,2);
  %centre = [(X(imax(1,1),1)+X(imin(1,1),1))/2,(X(imax(1,2),2)+X(imin(1,2),2))/2,(X(imax(1,3),3)+X(imin(1,3),3))/2];
  
  x1=X(imin(1,1),:);
   c=(sum(sqrt(sum((X-ones(size(X,1),1)*x1).^2,2))<=threshold)<number);
  while  (c==1)
    X=[X(1:imin(1,1)-1,:);X(imin(1,1)+1:size(X,1),:)];
    [maxi,imax]=max(X);
    [mini,imin]=min(X);
    x1=X(imin(1,1),:);
    c=(sum(sqrt(sum((X-ones(size(X,1),1)*x1).^2,2))<=threshold)<number);
  endwhile  
  x2=X(imin(1,2),:);
  c=(sum(sqrt(sum((X-ones(size(X,1),1)*x2).^2,2))<=threshold)<number);
  while  (c==1)
    X=[X(1:imin(1,2)-1,:);X(imin(1,2)+1:size(X,1),:)];
    [maxi,imax]=max(X);
    [mini,imin]=min(X);
    x2=X(imin(1,2),:);
    c=(sum(sqrt(sum((X-ones(size(X,1),1)*x2).^2,2))<=threshold)<number);
  endwhile  
  x3=X(imax(1,2),:);
  c=(sum(sqrt(sum((X-ones(size(X,1),1)*x3).^2,2))<=threshold)<number);
  while  (c==1)
    X=[X(1:imax(1,2)-1,:);X(imax(1,2)+1:size(X,1),:)];
    [maxi,imax]=max(X);
    [mini,imin]=min(X);
    x3=X(imax(1,2),:);
    c=(sum(sqrt(sum((X-ones(size(X,1),1)*x3).^2,2))<=threshold)<number);
  endwhile  
  x4=X(imax(1,1),:);
  c=(sum(sqrt(sum((X-ones(size(X,1),1)*x4).^2,2))<=threshold)<number);
  while  (c==1)
    X=[X(1:imax(1,1)-1,:);X(imax(1,1)+1:size(X,1),:)];
    [maxi,imax]=max(X);
    [mini,imin]=min(X);
    x4=X(imax(1,1),:);
    c=(sum(sqrt(sum((X-ones(size(X,1),1)*x4).^2,2))<=threshold)<number);
  endwhile  
  kp =maxi-mini;
  height=kp(1,3);
  centre(1,3)=(X(imax(1,3),3)+X(imin(1,3),3))/2;
   g =(((x1(1,2)-x2(1,2))*X(:,1))+((x2(1,1)-x1(1,1))*X(:,2))+(ones(size(X,1),1)*(x2(1,2)*x1(1,1)-x2(1,1)*x1(1,2))))/sqrt((x1(1,2)-x2(1,2))*((x1(1,2)-x2(1,2))')+(x2(1,1)-x1(1,1))*((x2(1,1)-x1(1,1))'));
   [dmin,idmin]= min(g);
   d = X(idmin,:);
   c=(sum(sqrt(sum((X-ones(size(X,1),1)*d).^2,2))<=threshold)<number);
  while  (c==1)
    X=[X(1:idmin-1,:);X(idmin+1:size(X,1),:)];
    g =(((x1(1,2)-x2(1,2))*X(:,1))+((x2(1,1)-x1(1,1))*X(:,2))+(ones(size(X,1),1)*(x2(1,2)*x1(1,1)-x2(1,1)*x1(1,2))))/sqrt((x1(1,2)-x2(1,2))*((x1(1,2)-x2(1,2))')+(x2(1,1)-x1(1,1))*((x2(1,1)-x1(1,1))')); 
    [dmin,idmin]= min(g);
    d = X(idmin,:);
    c=(sum(sqrt(sum((X-ones(size(X,1),1)*d).^2,2))<=threshold)<number);
  endwhile  
  %dmin
   theta = atan(-((x1(1,2)-x2(1,2))/(x1(1,1)-x2(1,1))));
   if (dmin<0)
     p =(x1(1,1:2)+x2(1,1:2))/2;
     k = [p(1,1)+dmin*sin(theta),p(1,2)+dmin*cos(theta)];
     else
     k = (x1(1,1:2)+x2(1,1:2))/2;dmin=0;
    endif
  [dmax,idmax]=max(g);
  d = X(idmax,:);
   c=(sum(sqrt(sum((X-ones(size(X,1),1)*d).^2,2))<=threshold)<number);
  while  (c==1)
    X=[X(1:idmax-1,:);X(idmax+1:size(X,1),:)];
    g =(((x1(1,2)-x2(1,2))*X(:,1))+((x2(1,1)-x1(1,1))*X(:,2))+(ones(size(X,1),1)*(x2(1,2)*x1(1,1)-x2(1,1)*x1(1,2))))/sqrt((x1(1,2)-x2(1,2))*((x1(1,2)-x2(1,2))')+(x2(1,1)-x1(1,1))*((x2(1,1)-x1(1,1))')); 
    [dmax,idmax]= max(g);
    d = X(idmax,:);
    c=(sum(sqrt(sum((X-ones(size(X,1),1)*d).^2,2))<=threshold)<number);
  endwhile
  length = dmax-dmin;
 
 
 
  theta2 =pi/2 - theta;
  h = -((((x1(1,2)-x3(1,2))*X(:,1))+((x3(1,1)-x1(1,1))*X(:,2))+ones(size(X,1),1)*(x3(1,2)*x1(1,1)-x3(1,1)*x1(1,2))))/sqrt((x1(1,2)-x3(1,2))*((x1(1,2)-x3(1,2))')+(x3(1,1)-x1(1,1))*((x3(1,1)-x1(1,1))')) ;
  [kmin,ikmin]=min(h);
  d = X(ikmin,:);
   c=(sum(sqrt(sum((X-ones(size(X,1),1)*d).^2,2))<=threshold)<number);
  while  (c==1)
    X=[X(1:ikmin-1,:);X(ikmin+1:size(X,1),:)];
    h = -((((x1(1,2)-x3(1,2))*X(:,1))+((x3(1,1)-x1(1,1))*X(:,2))+ones(size(X,1),1)*(x3(1,2)*x1(1,1)-x3(1,1)*x1(1,2))))/sqrt((x1(1,2)-x3(1,2))*((x1(1,2)-x3(1,2))')+(x3(1,1)-x1(1,1))*((x3(1,1)-x1(1,1))')) ;
    [kmin,ikmin]= min(h);
    d = X(ikmin,:);
    c=(sum(sqrt(sum((X-ones(size(X,1),1)*d).^2,2))<=threshold)<number);
  endwhile  
  if (kmin<0)
    t =(x1(1,1:2)+x3(1,1:2))/2;
      l = [t(1,1)+kmin*sin(theta2),t(1,2)-kmin*cos(theta2)];
     else
     l = (x1(1,1:2)+x3(1,1:2))/2;kmin=0;
  endif
  [kmax,ikmax]=max(h);
  d = X(ikmax,:);
   c=(sum(sqrt(sum((X-ones(size(X,1),1)*d).^2,2))<=threshold)<number);
  while  (c==1)
    X=[X(1:ikmax-1,:);X(ikmax+1:size(X,1),:)];
    h = -((((x1(1,2)-x3(1,2))*X(:,1))+((x3(1,1)-x1(1,1))*X(:,2))+ones(size(X,1),1)*(x3(1,2)*x1(1,1)-x3(1,1)*x1(1,2))))/sqrt((x1(1,2)-x3(1,2))*((x1(1,2)-x3(1,2))')+(x3(1,1)-x1(1,1))*((x3(1,1)-x1(1,1))')) ;
    [kmax,ikmax]= max(h);
    d = X(ikmax,:);
    c=(sum(sqrt(sum((X-ones(size(X,1),1)*d).^2,2))<=threshold)<number);
  endwhile  
  
  
  breadth = kmax-kmin;
  lambda = (k(1,1)-l(1,1))*cos(theta2)+(k(1,2)-l(1,2))*sin(theta2)+(length/2)*(sin(theta)*cos(theta2)+sin(theta2)*cos(theta))/(sin(theta)*cos(theta2)+sin(theta2)*cos(theta) );
  centre(1,1:2)= l+(breadth/2)*[sin(theta2),-cos(theta2)]+lambda*[sin(theta),cos(theta)];
  theta = pi/2 - theta;
  
  
endfunction
