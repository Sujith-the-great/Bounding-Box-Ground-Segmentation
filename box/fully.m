function y = fully(X,cen,radthres,thres,thetathres,cellthres)
  
 % Removing the points of the VELODYNE 
  H=[];
  m=size(X,1);
  for (i=1:m)
    a=X(i,:);
    if ((dist_sqr(a,[cen(1,1:2),a(3)]))<=(radthres^2))
      H=[H;a];
    endif  
  endfor
  y=1;
  [max_r,id_maxr] = max(dist_sqr([X(:,1:2),zeros(size(X,1),1)],[cen(1,1:2),0]))
  
  
  
  
endfunction








function y = dist_sqr(a,cen)
  m = size(a,1);
  y = sum(((a-(ones(m,1)*cen)).^2),2);
endfunction
