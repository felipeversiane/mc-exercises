
################################### MAIN
function main()
  clc;
  xl = 0.0;
  xu = 5.0;
  tol = 1e-6;
  maxInt = 1000;
  if f(xl)*f(xu) < 0
    [xr, xAll,fxAll,cont] = structure(xl,xu,tol,maxInt);
    fprintf("Resultado: f(%.5f) = %.5f \n",xr,f(xr));
    fprintf("Foi preciso %i interacoes \n",cont);
    plotCon(xAll,fxAll,cont);
    plotX(xl,xu,xAll,fxAll,cont);
  else
    fprintf("Intervalo nao existe na funcao");
    hold off;
  endif
end


################################### METHOD
function [xr, xAll,fxAll,cont] = structure(xl,xu,tol,maxInt)
clc
cont = 1;
xr = 0;
xAll = zeros(maxInt,1);
fxAll = zeros(maxInt,1);
  for cont = 1:maxInt
    xrold = xr;
    xr = (xl + xu)/2;
    xAll(cont) = xr;
    fxr = f(xr);
    fxAll(cont) = fxr;
    test = f(xl)*fxr;
    if test < 0
     xu=xr;
    elseif test > 0
     xl=xr;
    else
      break
    endif
    if(abs(xr-xrold) <= tol)
     break
    endif
  endfor
endfunction

################################### FUNCTION
function y = f(x)
  y = 16*x*sin(x/10) - 37/2;
end


################################### PLOT
function plotX(xl,xu,xAll,fxAll,cont)

  inter = xl:0.1:xu;
  y = zeros(size(inter));
  i = 1;
  for xx = inter
    y(i) = f(xx);
    i = i + 1;
  endfor

  for i = 1:cont
      figure(1);
      plot(inter, y, 'linewidth', 3, 'linestyle', '-', 'color', [0 0 1]);
      hold on;
      plot(xAll(i), fxAll(i), 'marker', 'o', 'markersize', 5, 'linewidth', 3, 'color', 'red', 'markerfacecolor', 'red');
      hold off;
      set(gca , "fontsize" , 12);
      legend("f(x)", "Posicao estimada da raiz");
      title(sprintf("Grafico na interacao %i = f(%5.5f) = %5.5f",i,xAll(i),fxAll(i)));
      xlabel("x");
      ylabel("y");
      grid on;
      pause(0.3)
     endfor
     hold off;
endfunction

function plotCon(xAll,fxAll,cont)
   figure(2);

   xPlot = xAll(1:cont);
   fxPlot = fxAll(1:cont);

   subplot(2,1,1);
   plot(1:cont,[xPlot],'color','k','linewidth',2);
   title("Grafico de convergencia da relacao xr");
   xlabel("Iteracoes");
   ylabel("xr");
   set(gca,'fontsize',12);
   grid on;
   xlim([1 cont]);
   ylim([min(xPlot) - 1, max(xPlot) + 1]);


   subplot(2,1,2)
   plot(1:cont,[fxPlot],'color','k','linewidth',2);
   title("Grafico de convergencia da relacao f(xr)");
   xlabel("Iteracoes");
   ylabel("fxr");
   set(gca,'fontsize',12);
   grid on;
   xlim([1 cont]);
   ylim([min(fxPlot) - 1, max(fxPlot) + 1]);
endfunction


