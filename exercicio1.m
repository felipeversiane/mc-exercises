
################################### MAIN
function exercicio1()
  clc;
  xl = 0.0;
  xu = 5.0;
  tol = 1e-5;
  maxInt = 1000;
  [xr, xAll,fxAll,cont] = structure(xl,xu,tol,maxInt);
  fprintf("Resultado: f(%.5f) = %.5f \n",xr,f(xr));
  fprintf("Foi preciso %i interacoes \n",cont);
  figure(1);(xl,xu,xAll,fxAll);
  figure(2);plotCon(xAll,fxAll);
  
end


################################### METHOD
function [xr1, xAll,fxAll,cont] = structure(xl,xu,tol,maxInt)
clc
cont = 0;
xrold = NaN;
xAll = zeros(maxInt,1);
fxAll = zeros(maxInt,1);
  for cont = 1:maxInt
    xr1 = (xl + xu)/2;
    xAll(cont) = xr1;
    fxr1 = f(xr1);
    test = f(xl)*fxr1;
    fxAll(cont) = fxr1;
    if test < 0
     xu=fxr1;
    elseif test > 0
     xl=xr1;
    else
      break
    endif
    if(abs(xr1-xrold) <= tol)
     break
    endif
    xrold = xr1;
  endfor
endfunction 

################################### FUNCTION
function y = f(x)
  y = 16*x*sin(x/10) - 37/2;
end


################################### PLOT
function plot(xl,xu,xAll,fxAll)
  inter = xl:0.1:xu;
  i = 1;
  y = zeros(size(inter));
    for xx = inter
      y(i) = f(xx);
      i = i + 1;
    endfor
    numIter = size(xAll,1);
    for inter =1:numIter
      plot(inter,y,"linewidth",2);
      hold on;
      plot(xAll(inter),fxAll(inter),o,'color',[0 0 1], "MarkerFaceColor" , [0 1 1]);
      hold off;
      set(gca , "fontsize" , 20);
      legend("f(x) =16*x*sin(x/10) - 37/2 ", "Posicao estimada da raiz");
      xlabel("x");
      ylabel("y");
      pause(0.2)
     endfor
endfunction

function plotCon(xAll,fxAll)
   numInter = size(xAll,1);
   clf;
   subplot(211);
   plot(1:numInter,xAll,'color','k','linewidth',2);
   title("Grafico de convergencia da relacao xr");
   xlabel("Iteracoes");
   ylabel("xr");
   set(gca,'fontsize',20);
   grid on;
   subplot(212)
   plot(1:numInter,fxAll,'color','k','linewidth',2);
   title("Grafico de convergencia da relacao fxr");
   xlabel("Iteracoes");
   ylabel("fxr");
   set(gca,'fontsize',20);
   grid on;
endfunction


