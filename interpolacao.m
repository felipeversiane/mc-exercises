 function interpolacao()
    clc
    degree = 4;
    x = [0;1;2;3;4;5];
    y = [0;0.5;0.8;0.9;0.941176;0.961538];
    xx = 4.7;
    if(numel(x)<degree+1)
      error("Nao sera possivel continuar");
    endif
    xVal = regressao(degree,x,y);
    yy = f(xVal,xx);
    [r2,r] = calcularR(x,y,xVal);
    fprintf("O resultado do polinomio estimado para x=4.7 eh: %f.5 \n",yy);
    fprintf("O resultado do r2 eh: %f.5 \n",r2);
    fprintf("O resultado do r eh: %f.5 \n",r);
    plotGrafico(xVal,x,y,xx,yy);
  endfunction

  function xVal = regressao(degree,x,y)
    m = zeros(degree+1,degree+2);
    A = zeros(degree+1,degree+1);
    b = zeros(degree+1,1);
    for i=1:degree+1
      for j=1:degree+1
        A(i,j) = sum(x.^(i+j-2));
      endfor
      b(i) = sum(x.^(i-1).*y);
    endfor
    xVal = zeros(degree+1,1);
    xVal = inv(A)*b;
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
    for i=length(xVal):-1:1
      y = y + xVal(i)*xx^(i-1);
    endfor
  endfunction

  function plotGrafico(xVal, x, y,xx,yy)
    auxX = x(1):0.1:x(end);
    auxY = zeros(size(auxX));

    for i = 1:numel(auxX)
      auxY(i) = f(xVal, auxX(i));
    endfor

    plot(auxX, auxY, 'color', 'k', 'linewidth', 2);
    hold on;

    plot(x, y,'o', 'markersize', 12, 'color', 'r', 'markerfacecolor', 'r');
    hold on;
    
    plot(xx, yy,'o', 'markersize', 12, 'color',  [0 1 1], 'markerfacecolor', [0 1 1]);
    hold off

    set(gca, 'fontsize', 12);
    title("Gráfico");
    legend("Função do polinômio", "Dados","Ponto estimado");
    grid on;
    xlabel("x");
    ylabel("y");
  endfunction
