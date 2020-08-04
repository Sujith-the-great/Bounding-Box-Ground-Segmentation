function y = convolution(a,b,stride)
  if size(size(b),2)>size(size(a),2)
    fprintf('error: dimensions of argument 2 exceeds that of argument 1. Convolution not possible.\n');
    else
      for i=1:size(size(b),2)
        if size(a,i)<size(b,i)
          fprintf('error: length of %f dimension of argument 2 exceeds that of argument 1. Hence convolution not possible.\n',floor(i));
        endif
      endfor
      
      if size(stride,2)!= size(size(a),2)
        fprintf('error: stride values for every dimension is not given.\n');
      endif 
      
      a_dim = size(a);
      b_dim = [size(b),ones(1,(size(size(a),2)-size(size(b),2)))];   
      for i=1:size(size(a),2)
        y_dim(1,i) = 1+floor((a_dim(1,i)-b_dim(1,i))/stride(1,i));
      endfor  
      
      y = loopy(a,b,y_dim,b_dim,stride,1);
      
      
 

 
        
    
   % dimension1 = size(size(a),2);
    %dimension2 = size(size(b),2);
    %y_dim = 
   
  endif 
endfunction


function z = loopy(a,b,y_dim,b_dim,stride,D)
  
  % here a is the input matrix which reduces with every for loop with varying start point and end point
  % here  is the filter matrix which is always constant.
  % here y_dim is the dimensions of the output matrix.
  % here D is the dimension of the nested for loop which is processing.
  
  if (size(y_dim,2)==0)
    z = total_sum((a.*b));    
  else
    for i=1:y_dim(1,1)
      res_a = modeling(a,(i-1)*stride(1,1)+1,(i-1)*stride(1,1)+b_dim(1,D),D);
      p{i} = loopy(res_a,b,y_dim(1,2:end),b_dim,stride(1,2:end),D+1);      
    endfor 
    z = combining(p);  
  endif
endfunction   


























function b = modeling(a,start,ending,m)
  
 % it models the given matrix from 'start' to 'ending' in 'm' dimension.
 % for example, let         a(:,:,1) = [1 2 3;4 5 6;7 8 9]
 %                          a(:,:,2) = [1 1 1;1 1 1;1 1 1]
 %                          a(:,:,3) = [2 2 2;3 3 3;4 4 4]
 % then let dimension to be modeled =         m =2
 % let starting line in that dimension =      start = 2 
 % let ending line in that dimension =        ending = 3
 % then         modeling(a,2,3,2) = ans
 %   ans(:,:,1) = [2 3;5 6;8 9]
 %   ans(:,:,2) = [1 1;1 1;1 1]
 %   ans(:,:,3) = [2 2;3 3;4 4]
 %fprintf('modeling starts now=\n');
 %a,start,ending,m
  b = zeros([(size(a))(1,1:(m-1)),(ending-start+1),(size(a))(1,(m+1):end)]);
  for i=1:product(size(a),(m+1),size(size(a),2))
   for j=1:((ending-start+1)*product(size(a),1,(m-1)))
    b(((i-1)*(ending-start+1)*product(size(a),1,(m-1)))+j)=a(((i-1)*product(size(a),1,m))+((start-1)*product(size(a),1,(m-1)))+j);
   endfor  
  endfor  
endfunction 





function b =combining(p)
  m = length(p);
  dim = size(p{1});
  num = product(dim,1,size(dim,2));
  b = zeros([m,dim]);
  for i=1:num
    for j=1:m
      b((i-1)*m+j)=p{j}(i);
    endfor    
  endfor
endfunction




function b = total_sum(a)
  
  % here 'a' is a matrix which is taken as input and the output is sum of all elements in that matrix.
  
  n = size(size(a),2);
  b = a;
  for i=1:n
    b = sum(b,i);
  endfor
endfunction


function b = product(a,start,ending)
   
 % this function is applied on a vector 'a' where the result is the product of the terms in the vector from 'start' to 'ending' positions.
 % for example, let a = [2 3 1 7 5 4]
 % then the product(a, 3 ,6) = 1 * 7 * 5 *4 = 140 
 
  b=1;
 for i=start:ending
   b =b*a(i); 
 endfor
endfunction
