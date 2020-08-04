%my image segmenter
function [b,y,nu_objects] = image_segmenter(a,tol)
  b = zeros(size(a));
  y=zeros(size(a,1),size(a,2));
  nu_objects =1;
  y(1,1) = 1;
  X{1} = [a(1,1,:)];
  
  for h=1:(size(a,1)-1)
    for w=1:(size(a,2)-1)
     if (y(h,w+1)==0)
      if (dist_sqr(a(h,w+1,:),a(h,w,:))<tol)
        y(h,w+1)=y(h,w);
        X{y(h,w)}=[X{y(h,w)};a(h,w+1,:)];
      else 
        nu_objects=nu_objects+1;
        y(h,w+1)=nu_objects;
        X{nu_objects}=[a(h,w+1,:)];
      endif
     endif 
      if (dist_sqr(a(h+1,w,:),a(h,w,:))<tol)
        y(h+1,w)=y(h,w);
        X{y(h,w)}=[X{y(h,w)};a(h+1,w,:)];
      elseif w==1
        nu_objects=nu_objects+1;
        y(h+1,w)=nu_objects;
        X{nu_objects}=[a(h+1,w,:)];
      endif
      
    endfor
  endfor
  
  
  for i=1:size(a,2)-1
    if (y(size(a,1),i)==0)&&(dist_sqr(y(size(a,1),i),y(size(a,1),i+1))<tol)
      y(size(a,1),i+1)=y(size(a,1),i);
    else
      nu_objects = nu_objects+1;
      y(size(a,1),i+1)=nu_objects;
      X{nu_objects} = [a(size(a,1),i+1,:)];
    endif   
  endfor   
  

   y
  
  k=zeros(nu_objects,1,3);
  
  for i=1:nu_objects
    k(i,1,:)=(sum(X{i},1)/size(X{i},1));
  endfor
  for h=1:size(a,1)
    for w =1:size(a,2)
     
      b(h,w,:)=k(y(h,w),1,:);
    endfor
  endfor
endfunction




function y = dist_sqr(a,b)
  y = sum((a-b).^2);
endfunction
