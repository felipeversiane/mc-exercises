function interpolacao()
  clc
  degree = 2;
  x = [0;1;2;3;4;5];
  y = [0;0.5;0.8;0.9;0.941176;0.961538];
  xx = 4.7;
  if(length(x)<degree+1)
    error("Nao sera possivel continuar");
  endif
  
endfunction

function [a,b]=regressao()

