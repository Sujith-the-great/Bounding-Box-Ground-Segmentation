function y = image_color_segmentation(X,k,max_iter)
  %  m = NUMBER OF EXAMPLES/IMAGES
  m = size(X,1);
        for c=1:k
          k_vector (c,1)=c;
        endfor    
  for i=1:m
    x = double(imread(X{i}))/255;
    dim1 = size(x,1);
    dim2 = size(x,2);
    dim3 = size(x,3);
    x = reshape(x,(dim1*dim2),dim3);
    r = randperm(size(x,1),k);
    for q = 1:k
      initial_mu(q,:) = x(r(1,q),:);
    endfor  
    mu_vector = initial_mu;
      for j=1:max_iter
        fprintf('running iteration:%d\n',j);
       [mu_vector,index_for_eachdata] = process_new_mu(mu_vector,x,k_vector);
      endfor
     for p=1:size(x,1)
       x(p,:) = mu_vector(index_for_eachdata(p,1),:);
     endfor
     x = reshape(x,dim1,dim2,dim3);
    y{i,1} = x; 
  endfor
endfunction
