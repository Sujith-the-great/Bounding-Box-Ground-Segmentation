function [multi_class_theta,predictor] = multiclass(X,y,lambda,A)
  m =length(y);
  [number_classes,result] = sorting(y);
  multi_class_theta = zeros(size(X,2),number_classes);
  for i=1:number_classes
    a=y;
    for j=1:m;
      if a(j)!=result(i)
        a(j)=0;
       else a(j)=1;
      endif
    endfor
   multi_class_theta(:,i) = optimization(X,a,lambda);
  endfor 
  fprintf('number of classes: \n');
fprintf(' %f \n', number_classes);
fprintf('multi_class_theta: \n');
fprintf(' %f \n', multi_class_theta);
 proto = A*multi_class_theta;
 predictor = zeros(size(proto,1),1);
 for i=1:size(A,1)
   [a,b]=max(proto(i,:));
   predictor(i) = result(b);
 endfor 
 fprintf('predictor: \n');
fprintf(' %f \n', predictor);
   
  
endfunction
