function [ground_points,non_ground_points] = ground_segmenation(X,theta,radius,height,thres)
  % [ground_points,non_ground_points]
  %% Here we are employing cylindrical coordiantes.
  %% theta is the angle to sepate between adjacent layers in initialization from centre(0,0,0).
  %% radius is the length of the each layer and height is the height of each layer.
  %% thres is the min distance that should be between two points inorder for them to be classified as adjacent. 
  % Initially we have to separate error points 
  
  ground_points = [];
  non_ground_points = [];
  max_dist =  max(sqrt(sum((X(:,1:2).^2),2)));
  nu_rad = ceil(max_dist/radius);
  if (nu_rad==0)
    nu_rad=1;
  endif
  K = {}; nu_layers=[];
  layer_length = (theta/360)*(2*pi*radius);
  max_height = max(X)(3);
  min_height = min(X)(3);
  nu_height = ceil((max_height-min_height)/height);
  if (nu_height==0)
    nu_height=1;
  endif
  for i=1:nu_rad
    nu_layers(i) = ceil((2*pi*radius*i)/layer_length);
    if (nu_layers(i)==0)
      nu_layers(i)=1;
    endif
    for j = 1:nu_height  
      K{i,j} = {};
      for k = 1:nu_layers(i)
        K{i,j}{k} = [];
      endfor   
    endfor
  endfor   
  
  m = size(X,1);
  for i=1:m
    a = X(i,:);
    if (((a(1)>(-0.2))&&(a(1)<4))&&((a(2)>(-1))&&(a(2)<1)))
      if (a(3)<0.05)
        ground_points = [ground_points;a];
      else
        non_ground_points = [non_ground_points;a];
      endif
    else  
      dista = sqrt((a(1:2)*(a(1:2)')));
      a_rad = ceil(dista/radius);
      if (a_rad==0)
        a_rad=1;
      endif   
      a_hig = ceil((a(3)-min_height)/height);
      if (a_hig==0)
        a_hig=1;
      endif
      a_len = ceil(angle(a)*nu_layers(a_rad)/360);
      if (a_len==0)
        a_len=1;
      endif
      K{a_rad,a_hig}{a_len} = [K{a_rad,a_hig}{a_len};a];
    endif 
  endfor   
  init_rads = ceil(5/radius);
  for i = 1:init_rads
    for j =1:nu_height
      for k = 1:nu_layers(i)
        curr_layer = K{i,j}{k};
        nu_k = size(curr_layer,1);
        for g = 1:nu_k
          a = curr_layer(g,:);
          if (a(3)<0.05)
            ground_points = [ground_points;a];
          else
            non_ground_points = [non_ground_points;a];
          endif
        endfor
      endfor
    endfor
  endfor
  for rad = (init_rads+1):nu_rad
    for hei = 1:nu_height
      for lay = 1:nu_layers(rad)
        curr_theta = 360*(lay/nu_layers(rad));
        index2 = ceil(theta*nu_layers(rad-1)/360);
        index1 = index2-1;
        if (index1==0)
          index1 = nu_layers(rad-1);
        endif
        index3 = index2+1;
        if (index3==nu_layers(rad-1)+1)
          index3 = 1;
        endif
        if (hei!=1)
          
        endif
      endfor
    endfor
  endfor
  
      
  
  
  
  
  
  
  
  
endfunction




function [sync] = layer_dimensionality(A,B,min_cost,min_theta,min_points)
  %% Here we are employing linear regression to find the centre and the perpendicular vector.
  m1 = size(A,1);
  m2 = size(B,1);
  theta1 = Optimization(A); 
  if (theta1(1)<0)
    theta1=-theta1;
  elseif (theta1(1)==0)
    if (theta1(2)<0)
    theta1=-theta1;
    elseif (theta1(2)==0)
      if (theta1(3)<0) 
        theta1=-theta1;
      endif
    endif 
  endif     
  theta2 = Optimization(B);
  if (theta2(1)<0)
    theta2=-theta2;
  elseif (theta2(1)==0)
    if (theta2(2)<0)
    theta2=-theta2;
    elseif (theta2(2)==0)
      if (theta2(3)<0)
        theta2=-theta2;
      endif
    endif 
  endif 
  image1 = A-(((A*theta1)-ones(m1,1))/(theta1'*theta1))*(theta1');
  centre1 = mean(image1);
  image2 = B-(((B*theta2)-ones(m2,1))/(theta2'*theta2))*(theta2');
  centre2 = mean(image2); 
  dist1 = ((A*theta1)-ones(m1,1));
  cost1 = sqrt(((dist1')*dist1)/(m1*(theta1'*theta1)));
  dist2 = ((B*theta2)-ones(m2,1));
  cost2 = sqrt(((dist2')*dist2)/(m2*(theta2'*theta2)));
  theta_diff1 = asin(cross(theta1,theta2)/(sqrt(theta1'*theta1)*sqrt(theta2'*theta2)));
  theta_mean = ((theta1+theta2)/2);
  centre_diff = (centre1-centre2)';
  theta_diff2 = asin(cross(theta_mean,centre_diff)/(sqrt(theta_mean'*theta_mean)*sqrt(centre_diff'*centre_diff)));
  sync = 0;
  if ((theta_diff1<min_theta)&&(theta_diff2<min_theta)&&(cost1<min_cost)&&(cost2<min_cost))
    sync = 1;
  endif 
endfunction

function [y,gradient] = cost_function(A,theta)
  %% A is a coordinate matrix with size m*3 and theta is a 1*3 vector.
  m = size(A,1);
  k = A*(theta)-ones(m,1);
  y = (1/(2*m))*((k')*k);
  gradient = (1/m)*((k')*A);
endfunction

function OptTheta = optimization(A)
  options = optimset('Gradobj','on','MaxIter',50);  
  initial_theta = [0;0;1];
  [OptTheta,functionalVal,exitflag] = fmincg(@(theta)(cost_function(A,theta)),initial_theta,options);
endfunction

function y = angle(a)
  if ((a(1)>=0)&&(a(2)>=0))
    y = (180/pi)*atan(a(2)/a(1));
  elseif ((a(1)<=0)&&(a(2)>=0))
    y = 180+(180/pi)*atan(a(2)/a(1));
  elseif ((a(1)<=0)&&(a(2)<=0))
    y = 180+(180/pi)*atan(a(2)/a(1));
  else 
    y = 360+(180/pi)*atan(a(2)/a(1));
  endif
  if ((a(1)==0)&&(a(2)==0))
    y = 0;  
  endif
endfunction
