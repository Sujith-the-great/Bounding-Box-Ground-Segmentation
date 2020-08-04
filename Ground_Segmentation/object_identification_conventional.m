function [K,nu_objects] = object_identification_conventional(X,threshold)
  %% X is m*3 matrix containing 'm' number of points with x,y,z coordinates.
  %% threshold is the maximum length considered for comparison between two adjacent points in order to be assigned as related to a same object.
  %% nu_objects is the total number of objects present in the given points.
  %% K is the cell of size nu_objects*1 with each unit contains matrix of poinnts contained in a single object.
  m = size(X,1);
  D = X;     tolsqr = threshold^2;
  nu_objects=0;
  if (m==0)
    K ={}; nu_objects=0;
  else
   while (size(D,1)!=0)
     nu_objects=nu_objects+1;
     K{nu_objects}=D(1,:);
     D = D(2:end,:);
     stage1 = K{nu_objects};  stage2 = [];
     
     while ((size(stage1,1)!=0)&(size(D,1)!=0))
     nu_stage1 = size(stage1,1);
     for j = 1:nu_stage1
       a = stage1(j,:);
       i=1;
       while (i<=size(D,1))
         if (dist_sqr(a,D(i,:))<=tolsqr)
           stage2=[stage2;D(i,:)];  D = [D(1:(i-1),:);D((i+1):end,:)]; 
         else 
           i = i+1;
         endif   
       endwhile  
     endfor
       K{nu_objects}=[K{nu_objects};stage2]; stage1=stage2; stage2=[];
     endwhile
   endwhile
  endif  
  
endfunction


function y = dist_sqr(a,b)
  y = sum(((a-b).^2),2);
endfunction
