function new_mu_vector = mean_mu(x,index_for_eachdata,k_vector)
  new_mu_vector = (1./sum(((index_for_eachdata')==k_vector),2)).*(((index_for_eachdata')==k_vector)*x);
endfunction
