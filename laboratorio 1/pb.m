function Y = pb(x)
  L=length(x);
  Y=zeros(1,L);
  for i = 1:L
    if ((i>=L*0.1)&&(i<=L*0.45))||((i>=L*0.55)&&(i<=L*0.90))
      Y(i)=x(i);
    endif
  endfor
endfunction