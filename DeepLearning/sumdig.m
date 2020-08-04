
function p = sumdig(a);
  i = 1; k = a; p=0;
  while(i==1)
   quo = k/10; div = 10*(quo -floor(quo)); k = floor(quo);
   p = p+div;
   if (k==0)
     i=0;
   endif   
  endwhile 
endfunction   
function y = pri();
x = [101    103    107    109    113 
    127    131    137    139    149 
    151    157    163    167    173 
    179    181    191    193    197
    199    211    223    227    229 
    233    239    241    251    257 
    263    269    271    277    281 
    283    293    307    311    313
    317    331    337    347    349 
    353    359    367    373    379
    383    389    397    401    409 
    419    421    431    433    439
    443    449    457    461    463 
    467    479    487    491    499 
    503    509    521    523    541 
    547    557    563    569    571 
    577    587    593    599    601 
    607    613    617    619    631 
    641    643    647    653    659 
    661    673    677    683    691 
    701    709    719    727    733 
    739    743    751    757    761 
    769    773    787    797    809 
    811    821    823    827    829 
    839    853    857    859    863 
    877    881    883    887    907 
    911    919    929    937    941 
    947    953    967    971    977  
    983    991    997   1009   1013]';
    x = reshape(x,size(x,1)*size(x,2),1);
    k = x;
    x = x-ones(size(x));
    m = size(x,1)
    for i=1:m
      a = x(i);
      %%(sqrt(a)==floor(sqrt(a)))
      if ((a/7)==floor((a/7)))
        %a
       %% ((a/11)==floor(a/11))
        if ((a/11)==floor(a/11))
        a
        endif
      endif   
    endfor
endfunction  


function p = lies(a,x);
  m = size(x,1);
  p=0;
  for i = 1:m
   k = x(i);
   if (k==a)
     p=1; break;
   endif  
  endfor
endfunction   
