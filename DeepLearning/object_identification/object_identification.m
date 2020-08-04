function  [y,nu_objects]  = object_identification(X,road_thickness,max_tolerance)
  k = min(X(:,3))+road_thickness;
  nu_points = size(X,1);
  y = zeros(nu_points,1);
  nu_objects = 1;
  O{1} = [];
  for i = 1:nu_points
    allotment = 0;
    if X(i,3)<k
      y(i) = 1;
      O{1} = [O{1};X(i)];     
     elseif nu_objects == 1
        nu_objects = 2;
        O{2} = [X(i,:)];
        y(i) = 2;
          else 
             for j =2:nu_objects
               for d = 1:size(O{j},1)
                  if dist(X(i,:),O{j}(d,:))<=max_tolerance
                     y(i) = j;
                     O{j}=[O{j};X(i,:)];
                     allotment = 1;
                     break;
                  endif
               endfor
               
               if allotment == 1
                 break;
               endif 
               
             endfor 
           if allotment != 1
             nu_objects = nu_objects+1;
             O{nu_objects} = [X(i,:)];
             y(i) = nu_objects;
           endif  
      
      
    endif   
  endfor   
    
  
endfunction











































function y = dist(x,y)
  if(((size(x,1)==1)||(size(x,2)==1))&&(size(x)==size(y)))
     y = sqrt(sum(((x-y).*2)));
   else
     fprintf('dimensions of argument 1 and argument 2 do not match or they are not vectors');
   endif  
endfunction
