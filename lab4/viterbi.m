function viterbi(input="110011")
  #es_inicial entrada es_sig  salida
  mt={"00" "0" "00" "00"
      "00" "1" "10" "11"
      "10" "0" "01" "01"
      "10" "1" "11" "10"
      "01" "0" "00" "11"
      "01" "1" "10" "00"
      "11" "0" "01" "10"
      "11" "1" "11" "01"};
  st=[1 1 2 2 3 3 4 4]
  simb=[0 1 0 1 0 1 0 1]
  char(mt(6,1));
  input_len=length(input)
  input=partir (input)
          
  t=hamming("001100","110011");
  PM=inf(4,input_len/2);
  BM=[];
  PM(1,1)=0;
  for i = 1:input_len/2
    current=input(1,i);
    for j=1:8
      BM(j,i)=hamming(char(current),char(mt(j,4)));
    endfor
  endfor
  for i=2:input_len/2
    for j=1:4
        PM(j,i)=min(PM(st(j),i-1)+hamming(st(j)+simb(j),i-1),PM(st(j+4),i-1)+hamming(st(j+4)+simb(j+4),i-1));
        PM(st(j),i-1)
        PM(st(j+4),i-1)
    endfor
  endfor
  k=input_len/2;
  code=[]
  min=inf
  for i=1:4
    if PM(i,k)<=min
       min=PM(i,k);
       min_indx=i;
    endif
  endfor
  a=
  k--;
  while k>=2
    min=inf;
     
    k--;
  endwhile
  BM
  PM
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
