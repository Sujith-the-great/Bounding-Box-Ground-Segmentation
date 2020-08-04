function [leng,brea,heig,theta,centre] = kk(X,cell_wid,thres,min_num,manual,nu_boxes_f_line)
 % Range of Cells
  % minimum values 
  [d,id]=min(X);
   a = X(id(1,1),:);
   while (sum((sum(((X-ones(size(X,1),1)*a).^2),2)<(thres^2)))<min_num)
     X=[X(1:(id(1,1)-1),:);X((id(1,1)+1):size(X,1),:)];
     [d,id]=min(X);
     a = X(id(1,1),:);
   endwhile
   length_min = d(1,1);
   a = X(id(1,2),:);
   while (sum((sum(((X-ones(size(X,1),1)*a).^2),2)<(thres^2)))<min_num)
     X=[X(1:(id(1,2)-1),:);X((id(1,2)+1):size(X,1),:)];
     [d,id]=min(X);
     a = X(id(1,2),:);
   endwhile
   breadth_min = d(1,2);
   a = X(id(1,3),:);
   while (sum((sum(((X-ones(size(X,1),1)*a).^2),2)<(thres^2)))<min_num)
     X=[X(1:(id(1,3)-1),:);X((id(1,3)+1):size(X,1),:)];
     [d,id]=min(X);
     a = X(id(1,3),:);
   endwhile
   height_min = d(1,3);
   [d,id]=max(X);
   a = X(id(1,1),:);
   while (sum((sum(((X-ones(size(X,1),1)*a).^2),2)<(thres^2)))<min_num)
     X=[X(1:(id(1,1)-1),:);X((id(1,1)+1):size(X,1),:)];
     [d,id]=max(X);
     a = X(id(1,1),:);
   endwhile
   length_max = d(1,1);
   a = X(id(1,2),:);
   while (sum((sum(((X-ones(size(X,1),1)*a).^2),2)<(thres^2)))<min_num)
     X=[X(1:(id(1,2)-1),:);X((id(1,2)+1):size(X,1),:)];
     [d,id]=max(X);
     a = X(id(1,2),:);
   endwhile
   breadth_max = d(1,2);
   a = X(id(1,3),:);
   while (sum((sum(((X-ones(size(X,1),1)*a).^2),2)<(thres^2)))<min_num)
     X=[X(1:(id(1,3)-1),:);X((id(1,3)+1):size(X,1),:)];
     [d,id]=max(X);
     a = X(id(1,3),:);
   endwhile
   height_max = d(1,3);
   c_length=length_max-length_min;
   c_breadth=breadth_max-breadth_min;
   c_height=height_max-height_min;
   % Cells K
   nu_len=ceil(c_length/cell_wid);
   nu_bre=ceil(c_breadth/cell_wid);
   nu_hei=ceil(c_height/cell_wid);
   K={};
   nu_ele=size(X,1); 
   i=1;
   for p=1:1:nu_len
     for q=1:1:nu_bre
       K{p,q}=[];
     endfor
   endfor
   while( i<=nu_ele)
     a=X(i,:);
     j=ceil((a(1)-length_min)/cell_wid);
     k=ceil((a(2)-breadth_min)/cell_wid);
     l=ceil((a(3)-height_min)/cell_wid);
     if ((j>0)&&(j<=nu_len)&&(k>0)&&(k<=nu_bre)&&(l>0)&&(l<=nu_hei))
       K{j,k}=[K{j,k};a];
       i=i+1;
     else 
       X = [X(1:i-1,:);X(i+1:size(X,1),:)];
       nu_ele=nu_ele-1;
     endif  
   endwhile
   b_mat=[];
   for (i=1:nu_len)
     j=1;
     allotment=0;
     while(j<=nu_bre&&allotment==0)
        m = size(K{i,j},1);
        for k=1:m
          
          if (num_sur(K{i,j}(k,:),i,j,K,thres,nu_len,nu_bre)>=min_num)
            b_mat=[b_mat,j];
            allotment=1;
            break;
          endif;
        endfor
        if(allotment==1)
          break;
        endif 
       j=j+1; 
     endwhile 
     if (allotment==0)
       b_mat=[b_mat,nu_bre];
     endif
   endfor
   
   t_mat=[];
   for (i=1:nu_len)
     j=nu_bre;
     allotment=0;
     while(j>=1&&allotment==0)
        m = size(K{i,j},1);
        for k=1:m
          
          if (num_sur(K{i,j}(k,:),i,j,K,thres,nu_len,nu_bre)>=min_num)
            t_mat=[t_mat,j];
            allotment=1;
            break;
          endif;
        endfor
        if(allotment==1)
          break;
        endif 
       j=j-1; 
     endwhile 
     if (allotment==0)
       t_mat=[t_mat,1];
     endif
   endfor
   
     l_mat=[];
   for (i=1:nu_bre)
     j=1;
     allotment=0;
     while(j<=nu_len&&allotment==0)
        m = size(K{j,i},1);
        for k=1:m
          
          if (num_sur(K{j,i}(k,:),j,i,K,thres,nu_len,nu_bre)>=min_num)
            l_mat=[l_mat,j];
            allotment=1;
            break;
          endif;
        endfor
        if(allotment==1)
          break;
        endif 
       j=j+1; 
     endwhile 
     if (allotment==0)
       l_mat=[l_mat,nu_len];
     endif
   endfor
   
   r_mat=[];
   for (i=1:nu_bre)
     j=nu_len;
     allotment=0;
     while(j>=1&&allotment==0)
        m = size(K{j,i},1);
        for k=1:m
          
          if (num_sur(K{j,i}(k,:),j,i,K,thres,nu_len,nu_bre)>=min_num)
            r_mat=[r_mat,j];
            allotment=1;
            break;
          endif;
        endfor
        if(allotment==1)
          break;
        endif 
       j=j-1; 
     endwhile 
     if (allotment==0)
       r_mat=[r_mat,1];
     endif
   endfor

   %xi=ones(1,nu_len)*length_min+di*[1:nu_len];
   %yi=ones(1,nu_len)*breadth_min+b_mat*((breadth_max-breadth_min)/nu_bre);
   %yi2=ones(1,nu_len)*breadth_min+t_mat*((breadth_max-breadth_min)/nu_bre);
   %[p1,functionalVal1] = perp([xi(1:8)',yi(1:8)']); % Left Lower 
   %[p2,functionalVal2] = perp([xi(nu_len:(-1):(nu_len-7))',yi(nu_len:(-1):(nu_len-7))']);  % Right Lower
   %[p3,functionalVal3] = perp([xi(1:8)',yi2(1:8)']);  % Left Upper
   %[p4,functionalVal4] = perp([xi(nu_len:(-1):(nu_len-7))',yi2(nu_len:(-1):(nu_len-7))']); % Right Upper
   [p1,functionalVal1] = perp(release(b_mat(1,1:nu_boxes_f_line),K,1));
   [p2,functionalVal2] = perp(release(b_mat(1,(nu_len-nu_boxes_f_line+1):nu_len),K,1));
   [p3,functionalVal3] = perp(release(t_mat(1,1:nu_boxes_f_line),K,1));
   [p4,functionalVal4] = perp(release(t_mat(1,(nu_len-nu_boxes_f_line+1):nu_len),K,1));
   [p5,functionalVal5] = perp(release(l_mat(1,1:nu_boxes_f_line),K,2));  % Left Lower
   [p6,functionalVal6] = perp(release(l_mat(1,(nu_bre-nu_boxes_f_line+1):nu_bre),K,2)); % Left Upper
   [p7,functionalVal7] = perp(release(r_mat(1,1:nu_boxes_f_line),K,2)); % Right Lower
   [p8,functionalVal8] = perp(release(r_mat(1,(nu_bre-nu_boxes_f_line+1):nu_bre),K,2));  % Right Upper
   F_mat = [functionalVal1;functionalVal2;functionalVal3;functionalVal4;functionalVal5;functionalVal6;functionalVal7;functionalVal8];

   p=perp(X);
   me = mean(X);
   ke=(me(1,1:2)*[1;(p(2)/p(1))]-(1/p(1)));
   %if (ke>=0)
   %  manual=2
   %else manual=1
   %endif
   plot(X(:,1),X(:,2),".")
   hold on;
   px=[-12,-11];
   py=[1,1]*(1/p(2))-(p(1)/p(2))*px;
   plot(px,py)
   
   [u,iu]=min(F_mat);
   if(iu==1)  
    theta = atan(-p1(1)/p1(2));
   endif
    if(iu==2)
    theta = atan(-p2(1)/p2(2));
   endif
   if(iu==3)
    theta = atan(-p3(1)/p3(2));
   endif
   if(iu==4)
    theta = atan(-p4(1)/p4(2));
   endif
   
   if(iu==5)  
    theta = atan(-p5(1)/p5(2));
   endif
    if(iu==6)
    theta = atan(-p6(1)/p6(2));
   endif
   if(iu==7)
    theta = atan(-p7(1)/p7(2));
   endif
   if(iu==8)
    theta = atan(-p8(1)/p8(2));
   endif
   
   if (manual==1)
     if(functionalVal1<functionalVal2)
       theta = atan(-p1(1)/p1(2));
     else
       theta = atan(-p2(1)/p2(2));
     endif  
   endif
   if (manual==2)
     if(functionalVal3<functionalVal4)
       theta = atan(-p3(1)/p3(2));
     else
       theta = atan(-p4(1)/p4(2));
     endif  
   endif
   if (theta<0)
      theta = pi/2 + theta;
   endif
   [dmin,idmin] = min(X(:,1:2)*[-sin(theta);cos(theta)]);
   a = X(idmin,:);
   c=(sum(sqrt(sum((X-ones(size(X,1),1)*a).^2,2))<=thres)<min_num);
  while  (c==1)
    X=[X(1:idmin-1,:);X(idmin+1:size(X,1),:)];
    [dmin,idmin] = min(X(:,1:2)*[-sin(theta);cos(theta)]);
   a = X(idmin,:);
   c=(sum(sqrt(sum((X-ones(size(X,1),1)*a).^2,2))<=thres)<min_num);
  endwhile  
  lmin=a;
  [dmax,idmax] = max(X(:,1:2)*[-sin(theta);cos(theta)]);
   a = X(idmax,:);
   c=(sum(sqrt(sum((X-ones(size(X,1),1)*a).^2,2))<=thres)<min_num);
  while  (c==1)
    X=[X(1:idmax-1,:);X(idmax+1:size(X,1),:)];
    [dmax,idmax] = max(X(:,1:2)*[-sin(theta);cos(theta)]);
   a = X(idmax,:);
   c=(sum(sqrt(sum((X-ones(size(X,1),1)*a).^2,2))<=thres)<min_num);
  endwhile
  lmax = a;
  lc=(lmax+lmin)(1,1:2)/2;
  leng=dmax-dmin;
  
  [bmin,ibmin] = min(X(:,1:2)*[cos(theta);sin(theta)]);
   a = X(ibmin,:);
   c=(sum(sqrt(sum((X-ones(size(X,1),1)*a).^2,2))<=thres)<min_num);
  while  (c==1)
    X=[X(1:ibmin-1,:);X(ibmin+1:size(X,1),:)];
    [bmin,ibmin] = min(X(:,1:2)*[cos(theta);sin(theta)]);
   a = X(ibmin,:);
   c=(sum(sqrt(sum((X-ones(size(X,1),1)*a).^2,2))<=thres)<min_num);
  endwhile  
  hmin=a;
  [bmax,ibmax] = max(X(:,1:2)*[cos(theta);sin(theta)]);
   a = X(ibmax,:);
   c=(sum(sqrt(sum((X-ones(size(X,1),1)*a).^2,2))<=thres)<min_num);
  while  (c==1)
    X=[X(1:ibmax-1,:);X(ibmax+1:size(X,1),:)];
    [bmax,ibmax] = max(X(:,1:2)*[cos(theta);sin(theta)]);
   a = X(ibmax,:);
   c=(sum(sqrt(sum((X-ones(size(X,1),1)*a).^2,2))<=thres)<min_num);
  endwhile
  hmax = a;
  bc=(hmax+hmin)(1,1:2)/2;
  brea=bmax-bmin;
    lambda = -((lc(1,1)-bc(1,1))*cos(theta)+(lc(1,2)-bc(1,2))*sin(theta));
    centre(1,1:2)=lc+lambda*[cos(theta),sin(theta)];
    [maxi,imax]=max(X);
    [mini,imin]=min(X);
    kp =maxi-mini;
  heig=kp(1,3);
  centre(1,3)=(X(imax(1,3),3)+X(imin(1,3),3))/2;
   
endfunction   

function n = num_sur(a,i,j,K,dist,nu_len,nu_bre)
    n=0;
 % Checking for the 27 cells in the surroundings
   if (i==1)
     i_min=i;
   else i_min=i-1;
   endif 
   if (j==1)
     j_min=j;
   else j_min=j-1;
   endif 
   if (i==nu_len)
     i_max=i;
   else i_max=i+1;
   endif 
   if (j==nu_bre)
     j_max=j;
   else j_max=j+1;
   endif 
   for p=i_min:1:i_max
     for q=j_min:1:j_max
         n=n+num(a,K{p,q},dist);
     endfor
   endfor
   n=n-1;
endfunction
function n = num(a,K,dist)
  n=0;
  m=size(K,1);
  if m>0
      n = sum(sum(((K-ones(m,1)*a).^2),2)<=(dist^2));
  else n=0;
  endif    
endfunction  
function [p,J] = perp(x)
   y=ones(size(x,1),1);
   options = optimset('Gradobj','on','MaxIter',50);
   initial_theta=rand(size(x,2),1);
   [OptTheta,functionalVal,exitflag] = fmincg(@(theta)(cost(x,y,theta)),initial_theta,options);
   p=OptTheta';J = cost(x,y,OptTheta);
 endfunction
  function [J,gradient] = cost(x,y,theta)
    m = length(y);
    J = (1/(2*m))*sum(((x*theta)-y).^2);
    gradient =(1/m)*(x')*(x*theta-y);
  endfunction  
  function [y] = release(mat,K,c)
    nu_units = size(mat,2);
    y=[];
    if (c==1)
     for i=1:nu_units
      y=[y;K{i,mat(1,i)}];
     endfor
    endif 
    if (c==2)
      for i=1:nu_units
      y=[y;K{mat(1,i),i}];
     endfor
    endif 
  endfunction   
