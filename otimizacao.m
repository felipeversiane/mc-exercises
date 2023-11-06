function otimizacao()
  clc
  maxIter = 1000;
  tol = 1e-3;
  x0 = [4;1];
  x = [3;0.5];
  is = 1;
  if is == 1
    a = 0.0163;
    [x1,cont,allX,allFx] = gradient(maxIter,tol,x0,a);
  elseif is == 2
    a = 0.0003;
    [x1,cont,allX,allFx] = newton(maxIter,tol,x0,a);
  endif
  [result] = distEuclidiana(x,x1);
  fprintf("O resultado do ponto minimo será de: \nx1 = %f.5 \nx2 = %f.5\n",x1(1),x1(2));
  fprintf("Em um total de %i iteracoes\n",cont);
  fprintf("Com a distancia euclidiana igual a : %f.5\n",result);
  plotConv(cont,allX,allFx);
  plotAll(cont,allX,allFx);
endfunction

function [result] = distEuclidiana(x,x1)
  result = sqrt((x(1)-x1(1))^2+(x(2)-x1(2))^2);
endfunction

function [x1,cont,allX,allFx] = gradient(maxIter,tol,x0,a)
  allX = zeros(maxIter,2);
  allFx = zeros(maxIter,2);
  for cont = 1:maxIter
       x1 = x0 - a*grad(x0);
       allX(cont,:) = x1;
       allFx(cont,:) = f(x1);
    if (max(abs(x1-x0))<= tol)
      break
    endif
    x0 = x1;
  endfor
  allX = allX(1:cont,:);
  allFx = allFx(1:cont,:);
endfunction

function [x1,cont,allX,allFx] = newton(maxIter,tol,x0,a)
  allX = zeros(maxIter,2);
  allFx = zeros(maxIter,2);
  for cont = 1:maxIter
       x1 = x0 - a*inv(hess(x0))*grad(x0);
       allX(cont,:) = x1;
       allFx(cont,:) = f(x1);
   if (max(abs(x1-x0))<= tol)
      break
    endif
    x0 = x1;
  endfor
  allX = allX(1:cont,:);
  allFx = allFx(1:cont,:);
endfunction

function plotAll(iter,allX,allFx)
  x = -10:0.1:10;
  y = x;
  z = zeros(length(x), length(y), 2);
  for xx = 1:numel(x)
    for yy = 1:numel(y)
      z(xx, yy, 1:2) = f([x(xx); y(yy)]);
    end
  end
   for cont = 1:iter
    figure(2);
    surf(x, y, z(:, :, 1));
    hold on
    plot3(allX(1:cont, 2), allX(1:cont, 1), allFx(1:cont, 1), 'color', 'r', 'linewidth', 2)
    plot3(allX(cont, 2), allX(cont, 1), allFx(cont, 1), 'o', 'markersize', 20, 'color', 'r', 'markerfacecolor', 'r', 'linewidth', 2)
    hold off
    set(gca, 'fontsize', 12);
    grid on;
    title(sprintf('Iteracao: %i; f(%.6f, %.6f) = %.6f', cont, allX(cont, 1), allX(cont, 2), allFx(cont, 1)));
    xlabel('x1', 'fontsize', 12);
    ylabel('x2', 'fontsize', 12);
    zlabel('f(x1, x2)', 'fontsize', 12);
    legend('f(x0)', 'rastro','solucao atual', 'location', 'northeast');
    pause(0.3);
  endfor
endfunction

function plotConv(cont,allX,allFx)
   figure(1);

   subplot(2,1,1);
   plot(1:cont,[allX(:, 1)],'color','k','linewidth',2);
   hold on
   plot(1:cont,[allX(:, 2)],'color','red','linewidth',2);
   hold off
   title("Grafico de convergencia da relacao x1");
   xlabel("Iteracoes");
   ylabel("(x1,x2)");
   legend("x1","x2");
   set(gca,'fontsize',12);
   grid on;


   subplot(2,1,2)
   plot(1:cont,[allFx(:,1)],'color','k','linewidth',2);
   hold on
   plot(1:cont,[allFx(:,2)],'color','red','linewidth',2);
   hold off
   title("Grafico de convergencia da relacao f(x1)");
   xlabel("Iteracoes");
   ylabel("f(x1,x2)");
   legend("x1","x2");
   set(gca,'fontsize',12);
   grid on;
endfunction


function h = hess(x0)
  x=x0(1);
  y=x0(2);
  h(1,1) = 2*y^6 + 2*y^4 - 4*y^3 - 2*y^2 - 4*y + 6;
  h(1,2) = 8*x*y^3 - 4*x*y + 9*y + 12*x*y^5 - 12*x*y^2 + 15.75*y^2 - 4*x + 3 ;
  h(2,1) = 8 * x * y^3 - 4 * x * y + 9 * y + 12 * x * y^5 - 12 * x * y^2 + 15.75 * y^2 - 4 * x + 3;
  h(2,2) = 12*x^2*y^2 - 2*x^2 + 9*x + 30*x^2*y^4 - 12*x^2*y + 31.5*x*y;

endfunction

function g = grad(x0)

  x=x0(1);
  y=x0(2);
  g = [2*x*y^4 + 6*x - 2*x*y^2 + 4.5*y^2 - 12.75 + 2*x*y^6 - 4*x*y^3 + 5.25*y^3 - 4*x*y + 3*y;
          4*x^2*y^3 - 2*x^2*y + 9*x*y + 6*x^2*y^5 - 6*x^2*y^2 + 15.75*x*y^2 - 2*x^2 + 3*x];
endfunction


function y = f(x)
  x1 = x(1);
  x2 = x(2);
  y = (x1.*x2.^2 - x1 + 2.25).^2 + (x1.*x2.^3 - x1 + 2.625).^2 + (x1.*x2 -x1 +1.5).^2;
endfunction
