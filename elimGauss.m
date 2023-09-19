 function elimGauss()
  clc
  x = zeros(3,1);
  A = [4 5 -8; 5 -3/2 4; -3 9 9];
  b = [32; -4; 3];
  
  #juntando a matriz A com b;
  Aa = [A b];
  
  #fazer pivotamento parcial antes !
  
  #comecando a zerar a matriz;
  
  i = 1;
  j=2;
  elemPivo = Aa(i,i);
  fator = Aa(j,i)/elemPivo;
  Aa(j,:) = Aa(j,:) - fator*Aa(i,:);
  j = 3;
  fator = Aa(j,i)/elemPivo;
  Aa(j,:) = Aa(j,:) - fator*Aa(1,:);
  
  #muda o elemento pivo
  
  j = 3;
  i = 2;
  elemPivo = Aa(i,i);
  fator = Aa(j,i)/elemPivo;
  Aa(j,:) = Aa(j,:) - fator*Aa(i,:);
  
  #nao precisa mais zerar nada
  
  # comeca a resolver as equacoes
  #achando o valor de z;
  i =3;
  x(i) = Aa(i,end)/Aa(i,j);
  
  #sumindo o z da equacao de cima;
  Aa(1:(i-1),i) = Aa(1:(i-1),i) *x(i);
  
  #achando o y;
  i=2;
  sub = (Aa(i,end)) - Aa(i,i+1);
  y = sub/Aa(i,i);
  x(i) = y;
  
  #sumindo o y da equacao de cimas;
  i = 1;
  j = 2;
  Aa(i:i,j) = Aa(i:i,j) * x(j);
  
  #achando o x;
  sub = (Aa(i,end)) - (sum(Aa(i,i+1:i+2)));
  xx = sub/Aa(i,i);
  x(i) = xx
 endfunction

