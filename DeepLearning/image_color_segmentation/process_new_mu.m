function  [mu_vector,index_for_eachdata] = process_new_mu(mu_vector,x,k_vector)
  index_for_eachdata = indexing(x,mu_vector);
  new_mu_vector = mean_mu(x,index_for_eachdata,k_vector);
  mu_vector = new_mu_vector;
endfunction
