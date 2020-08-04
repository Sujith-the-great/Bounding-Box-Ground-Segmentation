

function [kx,ky,ang] = trajectory(X,t1,t2,t)
  a = (inv([X(:,1).^3,X(:,1).^2,X(:,1),ones(size(X,1),1)]))*[X(:,2)];
  xma = max(X(:,1));
  xmi = min(X(:,1));
  xp = xmi:0.1:xma;
  yp = cubic(a,xp);
  plot(xp,yp);
  % 100 line segments     |||   101  points     |||      99 internal points    |||         2 external points
   x(1,1) = (X(1,1));
   x(101,1) = (X(4,1));
   dist(1,1) = 0;
  for i = 1:99
    x(i+1,1) = x(1,1)+(i/100)*(x(101,1)-x(1,1));
    y(i+1,1) = cubic(a,x(i,1));
    d(i,1) =  sqrt(((x(i+1,1)-x(i,1)).^2)+((y(i+1,1)-y(i,1)).^2));
    dist(i+1,1) = dist(i,1) + d(i,1);
  endfor
  y(101,1) = cubic(a,x(101,1)); 
  d(100,1) = sqrt(((x(101,1)-x(100,1)).^2)+((y(101,1)-y(100,1)).^2));
  dist(101,1) = dist(100,1) + d(100,1);
  vel = dist(101,1)/(t2-t1);
  req_dist = vel * (t-t1);
  for i = 1:100
    if (dist(i,1)<= req_dist)&&(req_dist <=dist(i+1,1))
      kx = x(i,1)+(((req_dist-dist(i,1))/(dist(i+1,1)-dist(i,1)))*(x(i+1,1)-x(i,1)));
      ky = cubic(a,kx);
      ang = 180*(atan(((3*a(1,1)*(kx^2))+(2*a(2,1)*kx)+a(3,1))))/pi;
      break;      
    endif  
  endfor
  if x(101,1)>x(1,1)
    if ang<0
      ang = 360 + ang;  
    endif 
  endif 
  if x(101,1)<x(1,1)
      ang = ang + 180;
  endif 
  
endfunction


function y = cubic(a,x)
   y = a(1,1)*(x.^3)+a(2,1)*(x.^2)+a(3,1)*(x)+a(4,1)*(ones(size(x,1),1));
endfunction
