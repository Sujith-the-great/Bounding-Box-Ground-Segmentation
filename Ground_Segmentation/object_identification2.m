function [y,nu_objects] = object_identification2(X,tol)
  maxi = max(X); x_max = maxi(1); y_max = maxi(2); z_max = maxi(3);
  mini = min(X); x_min = mini(1); y_min = mini(2); z_min = mini(3);
  n_x = ceil(sqrt(3)*(x_max-x_min)/tol);  n_y = ceil(sqrt(3)*(y_max-y_min)/tol);  n_z = ceil(sqrt(3)*(z_max-z_min)/tol);
  clear maxi,mini;
  if (n_x==0)
    n_x=1;
  endif
  if (n_y==0)
    n_y=1;
  endif
  if (n_z==0)
    n_z=1;
  endif  
  n_x
  n_y
  n_z
  m = size(X,1);
  point_index = zeros(m,3);
  K{n_x}{n_y}{n_z}=[]; 
  index{n_x}=zeros(n_y,n_z);
  for i=1:(n_x-1)
    index{i}=zeros(n_y,n_z);
  endfor  
  for i = 1:m
    a = X(i,:);
    x_i = ceil(sqrt(3)*(a(1)-x_min)/tol);  y_i = ceil(sqrt(3)*(a(2)-y_min)/tol);  z_i = ceil(sqrt(3)*(a(3)-z_min)/tol);
    if (x_i==0)
      x_i=1;
    endif 
    if (y_i==0)
      y_i=1;
    endif
    if (z_i==0)
      z_i=1;
    endif 
    K{x_i}{y_i}{z_i}=[K{x_i}{y_i}{z_i};a];  
    point_index(i,:)=[x_i,y_i,z_i];
  endfor
  clear a,x_i;
  clear y_i,z_i;
  tol_sqr = tol^2;  object_index=[];  
  %% Cells  are created. Now object identifcation has to be done.
  y = zeros(m,1);  nu_objects = 0;
  for i = 1:n_x
    for j = 1:n_y
      for k = 1:n_z
        a = K{i}{j}{k};        
        if (size(a,1)!=0)
         if (nu_objects==0)
          nu_objects=1;
          index{i}(j,k)=1;
          O{1}=[i,j,k];
          object_index =[1];
         else   
          if (i<3)
            i_min=1;
          else
            i_min=i-2;
          endif
          if (j<3)
            j_min=1;
          else
            j_min=j-2;
          endif
          if (k<3)
            k_min=1;
          else
            k_min=k-2;
          endif 
          if (i>(n_x-2))
            i_max=n_x;
          else
            i_max=i+2;
          endif
          if (j>(n_y-2))
            j_max=n_y;
          else
            j_max=j+2;
          endif
          if (k>(n_z-2))
            k_max=n_z;
          else
            k_max=k+2;
          endif
          c_allotment=0;
          for p=i_min:i_max
            for q=j_min:j_max
              for r=k:k_max
                if (r>k)
                  consider=1;
                elseif (q>j)
                  consider=1;
                elseif (p>i)  
                  consider=1;
                else 
                  consider=0;
                endif    
                if (consider==1)
                  b = K{p}{q}{r};
                  if (size(b,1)!=0)
                   % start of analysis between the two cells.
                    allotment=0;
                    for g = 1:size(a,1)
                      for h = 1:size(b,1)
                        if (dist_sqr(a(g,:),b(h,:))<=tol_sqr)
                          allotment=1;
                          break;
                        endif
                      endfor
                      if (allotment==1)
                        break;
                      endif  
                    endfor  
                    
                    if (allotment==1)
                     %% Both have of same object.
                      c_allotment=1;
                      if (index{i}(j,k)==0)
                       %% 1st cell is not indexed.  
                        if (index{p}(q,r)==0)
                         %% 2nd cell is not indexed. 
                          nu_objects=nu_objects+1;
                          index{i}(j,k)=nu_objects;
                          index{p}(q,r)=nu_objects;
                          O{nu_objects}=[i,j,k;p,q,r];
                          object_index=[object_index;nu_objects];
                        else 
                         %% 2nd cell is indexed. 
                          index{i}(j,k)=index{p}(q,r);
                          O{index{p}(q,r)}=[O{index{p}(q,r)};i,j,k];
                         %% End of 2nd cell indexing.                     
                        endif 
                      else
                       %% 1st cell is indexed. 
                        if (index{p}(q,r)==0)
                         %% 2nd cell is not indexed.
                          index{p}(q,r)=index{i}(j,k);
                          O{index{i}(j,k)}=[O{index{i}(j,k)};p,q,r];
                        else 
                         %% 2nd cell is indexed. 
                          if (size(O{index{i}(j,k)},1)>size(O{index{p}(q,r)},1))
                           %% size of 1st cell greater than that of 2nd cell. 
                            ind = index{i}(j,k);
                            tem = O{index{p}(q,r)};
                            ind2 = index{p}(q,r);
                            for l = 1:size(tem,1)
                              de = tem(l,:);
                              index{de(1)}(de(2),de(3))=ind;
                            endfor  
                            O{index{i}(j,k)}=[O{index{i}(j,k)};tem];
                            O{ind2}=[];
                            for gf = 1:size(object_index,1)
                              if (object_index(gf)==ind2)
                                kj = gf;
                                break;
                              endif  
                            endfor  
                            object_index = [object_index(1:(kj-1));object_index((kj+1):end)];
                          else
                           %% size of 2nd cell greater than that of 1st cell.
                            ind = index{p}(q,r);
                            tem = O{index{i}(j,k)};
                            ind2 = index{i}(j,k);
                            for l = 1:size(tem,1)
                              de = tem(l,:);
                              index{de(1)}(de(2),de(3))=ind;
                            endfor  
                            O{index{p}(q,r)}=[O{index{p}(q,r)};tem];
                            O{ind2}=[];
                            for gf = 1:size(object_index,1)
                              if (object_index(gf)==ind2)
                                kj = gf;
                                break;
                              endif  
                            endfor  
                            object_index = [object_index(1:(kj-1));object_index((kj+1):end)];
                           %% End of size comparison.
                          endif  
                         %% End of 2nd cell indexing.
                        endif 
                       %% End of 1st cell indexing.
                      endif     
                     %% End of allotment analysis.                    
                    endif  
                   % end of analysis between two cells.
                  endif  
                endif
                
              endfor
            endfor
          endfor  
          if ((c_allotment==0)&(index{i}(j,k)==0))
            nu_objects=nu_objects+1;
            O{nu_objects}=[i,j,k];
            object_index=[object_index;nu_objects];
          endif  
         endif
        endif  
      endfor
    endfor
  endfor
  
 object_index   
    
    
    
    
    
    
    
endfunction


function y = dist_sqr(a,b)
  y = sum(((a-b).^2),2);
endfunction  