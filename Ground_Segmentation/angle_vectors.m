function y = angle_vectors(a,b)
  y = (180/pi)*acos(dot(a,b)/(sqrt(sum(a.^2))*sqrt(sum(b.^2))));
  y = (y+conj(y))/2;
  if (y>90)
    y = 180-y;
  endif  
endfunction