function x_n = FourierTrigonometrica(f,T,N,a=-T/2,b=T/2)
  
  function y = SerieFourierTrigonometrica(f,T,N,a,b,t)
    y = ((2/T)*quad(inline("f(t)*cos(0)","t"),a,b))/2;
    for k=1 : N
      a_k = (2/T)*quad(inline("f(t)*cos(k*((2*pi)/T)*t)","t"),a,b);
      b_k = (2/T)*quad(inline("f(t)*sin(k*((2*pi)/T)*t)","t"),a,b);
      y += a_k*cos(k*((2*pi)/T)*t) + b_k*sin(k*((2*pi)/T)*t);
    endfor
  endfunction
  
  x = a:T/500:b;
  subplot(2,2,1);
  plot(x,f(x),'-b'); xlabel('t'); ylabel('x(t)'); axis([a b]); title("Función original");
  subplot (2,2,2);
  plot(x,SerieFourierTrigonometrica(f,T,N,a,b,x),'-r'); xlabel('t'); ylabel('x_n(t)'); axis([a b]); title(strcat('f_n(t) para N=', num2str(N)));
  subplot(2,2,3);
  plot(x,SerieFourierTrigonometrica(f,T,5,a,b,x),'-r'); xlabel('t'); ylabel('x_n(t)'); axis([a b]); title("f_n(t) para N=5");
  subplot(2,2,4);
  plot(x,SerieFourierTrigonometrica(f,T,50,a,b,x),'-r'); xlabel('t'); ylabel('x_n(t)'); axis([a b]); title("f_n(t) para N=50");
endfunction