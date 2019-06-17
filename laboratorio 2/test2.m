function test2(m=@(x)sin(x),f=1)      #m funcion, f frecuencia, A amplitud       
  #muestreo

  fs=90*f;                        #frecuencia de muestreo
  T=1/(f);                        #periodo 
  t=0:1/fs:T;                     #vector de tiempo           
  ms=m(2*pi*t*f);
  A=round(max(ms))
  #quantizacion
  L=16                             #niveles de quantizacion
  n=log2(L)
  subplot(4,1,1);plot(t,ms);axis([0 T -A-0.2 A+0.2]);title('funcion muestreada');xlabel('t'); ylabel('m(t)');
  delta = 2*A/L
  Qi=floor((ms-(-A))/delta);       #vector indices de quantizacion
  Q=(Qi.*delta+delta/2)-A;         
  subplot(4,1,2);plot(t,Q);axis([0 T -A-0.2 A+0.2]);title('funcion cuantizada');xlabel('t'); ylabel('m(t)');
  S=[-A:delta:A];
  for i=S
    line([0,T],[i,i]);
  endfor
  
  #codificacion
  r=dec2bin(Qi,n);
  #bipolar NRZ
  r=transpose(r);
  r=reshape(r,1,length(Qi)*n);
  s=zeros(1,length(r));
  for i = 1:length(r)
    s(i)=str2num(r(i));
    if s(i)==0
      s(i)=-1;
    endif
  endfor
  bipolar=zeros(1,length(s)*50);
  for i =1:length(s)
    bipolar((i-1)*50+1:i*50)=s(i);
  endfor 
  
  subplot(4,1,3);plot(1:length(bipolar),bipolar,"color","k");axis([0 3000 -1.5 1.5]);grid;
  title('NRZ bipolar');
  #line([0,3000], [0,0],"color","b");
  for i=1:60
    line([i*50 i*50],[-1.3 1.3],"color","b","linestyle", "--");
  endfor
  #demodulacion 
  Ts=1/fs;
  mr=zeros(length(t));
  for i=1:length(t)
    for j=1:length(t) 
      mr(i)=mr(i)+Q(j)*sinc(f*(i-Ts));
    endfor
  endfor
  subplot(4,1,4);plot(t,mr);
  %mn=fft(ms(t))
  #plot(t,mn)
  
endfunction