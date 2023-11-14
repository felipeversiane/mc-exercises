function interpolacao()
  clc
  degree = 2;
  x = [0;1;2;3;4;5];
  y = [0;0.5;0.8;0.9;0.941176;0.961538];
  xx = 4.7;
  if(numel(x)<degree+1)
    error("Nao sera possivel continuar");
  endif
  [A,b,xVal] = regressao(degree,x,y);
  [r2,r] = calcularR(x,y,xVal);
  fprintf("O resultado do polinomio estimado para x=4.7 eh: %f.5 \n",f(xVal,xx));
  fprintf("O resultado do r2 eh: %f.5 \n",r2);
  fprintf("O resultado do r eh: %f.5 \n",r);
  plotGrafico(xVal,xx,x,y)
  
endfunction

function [A,b,xVal]=regressao(degree,x,y)
  for i=1:degree+1
    for j=1:i
      k = i + j - 2;
      soma = 0;
      for l=1:numel(x)
        soma = soma + x(l)^k;
      endfor
      a(i,j) = soma;
      a(j,i) = soma;      
    endfor
    soma = 0;
    for l=1:numel(x)
      soma = soma + y(l)*x(l)^(i-1);
    endfor
    a(i,degree+2)= soma;
  endfor
  A = a(:,1:end-1);
  b = a(:,end);
  xVal = A\b;
endfunction

function [r2,r] = calcularR(x,y,xVal)
  sr = 0;
  st = 0;
  for i=1:numel(x)
    sr = sr +(y(i) - f(xVal,x(i)))^2;
    st = st + (y(i) - mean(y))^2;
  endfor
  r2 = (st - sr)/st;
  r = sqrt(r2);
endfunction

function y = f(xVal,xx)
  y = 0;
  for i=numel(xVal):-1:1
    y = y + xVal(i)*xx^(i-1);
  endfor
endfunction

function plotGrafico(xVal,xx,x,y)
  
endfunction

