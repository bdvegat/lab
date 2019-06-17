function Y = sb(x)
  L=length(x);
  Y=x;
  for i = 1:L
    if ((i>=L*0.1)&&(i<=L*0.45))||((i>=L*0.55)&&(i<=L*0.90))
      Y(i)=0;
    endif
  endfor
endfunction