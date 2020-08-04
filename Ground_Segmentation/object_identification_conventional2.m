function [K,nu_objects] = object_identification_conventional2(X,threshold)
  %% X is m*3 matrix containing 'm' number of points with x,y,z coordinates.
  %% threshold is the maximum length considered for comparison between two adjacent points in order to be assigned as related to a same object.
  %% nu_objects is the total number of objects present in the given points.
  %% K is the cell of size nu_objects*1 with each unit contains matrix of poinnts contained in a single object.
  m = size(X,1);  nu_rem = m; checked = zeros(m,1);
  start=1;  tolsqr = threshold^2;
  K={}; nu_objects=0;
  while (nu_rem!=0)
    nu_objects = nu_objects+1;
    K{nu_objects}=zeros(nu_rem,3); nu_K=0;
    K{nu_objects}(1,:)=X(start,:); nu_K=1; nu_rem=nu_rem-1; checked(start)=1;
    stage1=X(start,:); stage2=zeros(nu_rem,3);
    nu_stage1=1; nu_stage2=0;
    while((nu_stage1!=0)&(nu_rem!=0))
      for i=1:nu_stage1
        a=stage1(i,:);
        k=start+1;
        while ((k<=m))
          if (checked(k)==0)
            if (dist_sqr(a,X(k,:))<=tolsqr)
              checked(k)=1; nu_rem=nu_rem-1; nu_stage2=nu_stage2+1;  stage2(nu_stage2,:)=X(k,:); k
            endif  
          endif
          k=k+1;
        endwhile  
      endfor  
      stage2=stage2(1:nu_stage2,:); stage1=stage2; K{nu_objects}((nu_K+1):(nu_K+size(stage1,1)),:)=stage1; nu_stage1=size(stage1,1); 
      nu_K = nu_K+size(stage1,1); stage2=zeros(nu_rem,3); nu_stage2=0;
    endwhile
    K{nu_objects}=K{nu_objects}(1:nu_K,:);
    
    
    
    start=start+1;
    while (start<=m)
      if (checked(start)==0)
        break;
      else
        start=start+1;
      endif 
    endwhile
    start
  endwhile  
    
endfunction


function y = dist_sqr(a,b)
  y = sum(((a-b).^2),2);
endfunction
