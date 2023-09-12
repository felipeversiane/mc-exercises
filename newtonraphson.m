function newtonraphson()
  clc
  maxInt = 1000;
  x0 = [0.5;1;0];
  tol = 1e-5;
  [allX,allFx,cont,x1] = structure(maxInt,tol,x0);
  fprintf("Levou %i iteracoes para achar a raiz \n",cont);
  fprintf("A raiz de x :%5.5f \n",x1(1));
  fprintf("A raiz de y :%5.5f \n",x1(2));
  fprintf("A raiz de z :%5.5f \n",x1(3));
  plotCon(allX,allFx,cont);
endfunction

function [allX,allFx,cont,x1] = structure(maxInt,tol,x0)
  allX = zeros(maxInt,3);
  allFx= zeros(maxInt,3);
  for cont = 1:maxInt
    allFx(cont, :) = sistem(x0);
    x1 = x0 - inv(jacob(x0))*sistem(x0);
    allX(cont, : ) = x1;
    if max(abs(x1-x0)) <= tol
      break
    endif
    x0=x1;
    hold on
    pause(0.3)
  endfor
  allX = allX(1:cont, :);
  allFx = allFx(1:cont, :);
endfunction

function s = sistem(x0)
  x = x0(1);
  y = x0(2);
  z = x0(3);
  s = [6.*x - 2.*y + exp(z) - 2;
        sin(x) - y + z ;
        sin(x) + 2.*y + 3.*z - 1];
endfunction

function j = jacob(x0)
  x = x0(1);
  y = x0(2);
  z = x0(3);
  j = [6,-2,exp(z);
      cos(x),-1,1;
      cos(x),2,3];
endfunction

function plotCon(allX,allFx,cont)
   figure(1);

   xPlot = allX(1:cont, :);
   fxPlot = allFx(1:cont, :);

   subplot(2,1,1);
   plot(1:cont,[xPlot(:, 1)],'color','k','linewidth',2);
   hold on
   plot(1:cont,[xPlot(:, 2)],'color','red','linewidth',2);
   plot(1:cont,[xPlot(:, 3)],'color','blue','linewidth',2);
   hold off
   title("Grafico de convergencia da relacao x1");
   xlabel("Iteracoes");
   ylabel("(x,y,z)");
   legend("x","y","z");
   set(gca,'fontsize',12);
   grid on;


   subplot(2,1,2)
   plot(1:cont,[fxPlot(:,1)],'color','k','linewidth',2);
   hold on
   plot(1:cont,[fxPlot(:,2)],'color','red','linewidth',2);
   plot(1:cont,[fxPlot(:,3)],'color','blue','linewidth',2);
   hold off
   title("Grafico de convergencia da relacao f(x1)");
   xlabel("Iteracoes");
   ylabel("f(x,y,z)");
   legend("x","y","z");
   set(gca,'fontsize',12);
   grid on;
endfunction






