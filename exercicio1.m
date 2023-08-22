function structure()
clc
cont = 0;
tol = 1e-6;
xl = 0.0; 
xu = 5.0;
  for cont = 1:1000
    xr = (xl + xu)/2;
    test = f(xl)*f(xr);
    if test < 0
     xu=xr;
    elseif test > 0
     xl=xr;
    else
    break
    endif
    if(abs(xl-xu) < tol)
    break
    end
    fprintf("O xr:%5.2f . O xl:%5.5f. O xu:%5.5f \n",xr,xl,xu);
  end
  fprintf("A raiz da funcao foi encontrada : %5.5f\n",xr);
  fprintf("Foi necessaria %d interacoes \n",cont);
end 

function y = f(x)
  y = 16*x*sin(x/10) - 37/2;
end

function plot(x, y, x2, y2)
  figure(1);
  clf;
  
  
    ylabel('y');
    xlabel('x');
    title('f(x) = 16*x*sin(x/10) - 37/2');
    pause(0.1);
end