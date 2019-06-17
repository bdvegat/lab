function Y = hf(x)
  L=length(x);
  Y=zeros(1,L);
  for i = 1:L
    if (i<=L*0.3)||(i>=L*0.70)
      Y(i)=x(i);
    endif
  endfor
endfunction