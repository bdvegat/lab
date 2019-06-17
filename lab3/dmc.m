function dmc(PX=[0.4 0.6],PY_X=[0.9 0.1; 0.2 0.8])
  PX              %P(X)
  PY_X            %P(X|Y)
  #P(Y) 
  PY=PX*PY_X      %P(Y)
  #P(X,Y)
  PXd=diag(PX);
  PXY=PXd*PY_X    %P(X,Y)
  
  #H(X)
  HX=0;
  for i= 1:length(PX)
    HX-=PX(i)*log2(PX(i));    
  endfor
  HX              %H(X,Y)
  #H(Y|X)
  HY_X=0;
  for j= 1:length(PY)
    for i = 1:length(PX)
      if (PXY(i,j)==0)
        continue
      endif
      HY_X-=PXY(i,j)*log2(PY_X(i,j));
    endfor 
  endfor
  HY_X            %H(Y|X)  
  #H(Y)
  HY=0;
  for i =1:length(PY)
    if PY(i)==0
      continue
    endif
    HY-= PY(i)*log2(PY(i));
  endfor
  HY            %H(Y)
  
  #H(X,Y)
  HXY=0;
  for j= 1:length(PY)
    for i = 1:length(PX)
      if (PXY(i,j)==0)
        continue
      endif
      HXY-=PXY(i,j)*log2(PXY(i,j));
    endfor 
  endfor
  HXY           %H(X,Y)
  HY_X
  HY_X2=HXY-HX
  #I(X;Y)
  HX_Y=HXY-HY   %H(Y_X)
  IXY=HX-HX_Y   %I(X;Y)
  #Cs
  if rows(PY_X)==2 && columns(PY_X)==2
    p=PY_X(1,2);
    if PY_X(1,1)==1-p && PY_X(2,1)==p && PY_X(2,2)==1-p
      if p==0
        Cs=1
      else
        Cs=1+p*log2(p)+(1-p)*log2(1-p)
      endif 
    endif 
  endif
  
endfunction
