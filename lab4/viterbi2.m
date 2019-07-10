function viterbi2(input="1101000111")
  #es_inicial entrada es_sig  salida
  mt={"00" "0" "00" "00"
      "00" "1" "10" "11"
      "10" "0" "01" "01"
      "10" "1" "11" "10"
      "01" "0" "00" "11"
      "01" "1" "10" "00"
      "11" "0" "01" "10"
      "11" "1" "11" "01"};
      
  st=[1 1 2 2 3 3 4 4];
  aux=[1 3 5 7];
  simb=[0 1 0 1 0 1 0 1];
  
  input_len=length(input);
  input=partir (input);
  PM=inf(4,input_len/2);
  BM=[];
  PM(1,1)=0;
  path=[];
  out={};
  for i = 1:input_len/2
    current=input(1,i);
    for j=1:8
      BM(j,i)=hamming(char(current),char(mt(j,4)));
    endfor
    for j=1:4
      a=st(j);
      sa=simb(j);
      b=st(j+4);
      sb=simb(j+4);
      if PM(a,i)+BM(aux(a)+sa,i)<=PM(b,i)+BM(aux(b)+sb,i)
        PM(j,i+1)=PM(a,i)+BM(aux(a)+sa,i);
        path(j,i)=a;
        out(j,i)=mt(aux(a)+sa,4);
        PM(j,b)=inf;
      else
        PM(j,i+1)=PM(b,i)+BM(aux(b)+sb,i);
        path(j,i)=b;
        out(j,i)=mt(aux(b)+sb,4);
        PM(j,a)=inf;
      endif
    endfor
        graficar(path,PM,i);
  endfor
  k=length(PM);
  c=[];
  min=inf;
  for i=1:4
    if PM(i,k)<=min
       min=PM(i,k);
       min_indx=i;
    endif
  endfor
  c(k)=min_indx;
  k--;
  while k>=1
    c(k)=path(min_indx,k);
    min_indx=path(min_indx,k);
    k--;
  endwhile
  
  BM;
  PM
  path
  c=dec(c,out);
  d=decode(c);
  fprintf('c = ')
  fprintf(1, '%s ', c{:})
  fprintf(1, '\n')
  
  fprintf('d = ')
  fprintf(1, '%s ', d{:})
  fprintf(1, '\n')
  endfunction

function [dist]=hamming(s1,s2) 
  dist=0;
  for i = 1:length(s1)
    if s1(i)!=s2(i)
      dist++;
    endif
  endfor
  dist;
endfunction

function [ans]=partir(str)
  ans={};
  j=1;
  for i = 1:2:length(str)
    ans(j)=strcat(str(i), str(i+1));
    j=j+1;
  endfor
endfunction

function ans=dec(path,out)
  ans={};
  for i=2:length(path)
    current=path(i);
    ans(i-1)=out(current,i-1);
  endfor
endfunction

function ans = decode(str)
  ans={};
  state=1;
  for i=1:length(str)
    state;
    current=char(str(1,i));
    if state==1
      if current=="00"
        ans(i)="0";
        state=1;
      else
        ans(i)="1";
        state=2;
      endif
      continue
    endif
    if state==2
      if current=="01"
        ans(i)="0";
        state=3;
      else
        ans(i)="1";
        state=4;
      endif
      continue
    endif
    if state==3
      if current=="11"
        ans(i)="0";
        state=1;
      else
        ans(i)="1";
        state=2;
      endif
      continue
    endif
    if state==4
      if current=="10"
        ans(i)="0";
        state=3;
      else
        ans(i)="1";
        state=4;
      endif
      continue
    endif
  endfor
endfunction 

function graficar(path,PM,i)
  k=i
  if k==1
    return
  endif
  subplot(3,2,k-1);
  for i=0:4
    line ([0 k+1], [i i], "linestyle", "--", "color", "b");
  endfor
  while k>=2
    k--;
  endwhile
endfunction
