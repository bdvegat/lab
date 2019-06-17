Fs = 150                      #frecuencia de muestreo
a=1                             #longitud del pulso
t=[-a:1/Fs:a];              #vector de tiempo
f=1*((t>-a/2)&(t<a/2));         #pulso rectangular

subplot(3,2,1);plot(t,f);xlabel('t'); ylabel('x(t)'); title('Pulso Rectangular');axis([-2*a 2*a -0.1 1.1]);

X=fft(f);                     #calcular la transformada de fourier
X1=fftshift(X);                 #centrar la tranformada de fourier
nfft=length(X);
Y=abs(X1);                      #calcular la magnitud de la tranformada de fourier
w = (-(nfft-1)/2:(nfft-1)/2)*Fs/nfft;     #calcular el dominio de la frecuencia
subplot(3,2,2);plot(w, Y);axis([-40 40 0 160]);title('Transformada de fourier');xlabel('w'); ylabel('X(w)');
low=lowF(X1);               #aplicar el filtro pasa bajas a la funcion centrada en 0
low=ifft(ifftshift(low));   #revertir el centrado de la funcion y aplicar ifft 
subplot(3,2,3);plot(t, low);axis([-2*a 2*a -0.1 1.1]);title('Filtro pasa bajas');xlabel('t'); ylabel('x(t)');
high=hf(X1);                #aplicar el filtro pasa bajas a la funcion centrada en 0
high=ifft(ifftshift(high)); #revertir el centrado de la funcion y aplicar ifft
subplot(3,2,4);plot(t, high);axis([-2*a 2*a -0.1 1.1]);title('Filtro pasa altas');xlabel('t'); ylabel('x(t)');
pasaBandas = pb(X1);        #aplicar el filtro pasa bajas a la funcion centrada en 0
pasaBandas = ifft(ifftshift(pasaBandas));  #revertir el centrado de la funcion y aplicar ifft
subplot(3,2,5);plot(t, pasaBandas);axis([-2*a 2*a -0.1 1.1]);title('Filtro pasa bandas');xlabel('t'); ylabel('x(t)');
supBandas = sb(X1);         #aplicar el filtro pasa bajas a la funcion centrada en 0
supBandas = ifft(ifftshift(supBandas));  #revertir el centrado de la funcion y aplicar ifft
subplot(3,2,6);plot(t, supBandas);axis([-2*a 2*a -0.1 1.1]);title('Filtro suprime bandas');xlabel('t'); ylabel('x(t)');