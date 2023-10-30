function otimizacao()
  clc
  maxIter = 1000;
  tol = 1e-3;
  x0 = [4;
        1];
  is = 2;
  if is == 1
    a = 3;
    [x1,cont] = gradient(maxIter,tol,x0,a);
  elseif is == 2
    a = 0.10;
    [x1,cont] = newton(maxIter,tol,x0,a);
  endif
  x1
  cont
endfunction

function [x1,cont] = gradient(maxIter,tol,x0,a)
  for cont = 1:maxIter
       x1 = x0 - a*g(x0);
    if (abs(max(x1-x0)) <= tol)
      x0 = x1;
      break
    endif
    x0 = x1;
  endfor
endfunction

function [x1,cont] = newton(maxIter,tol,x0,a)
  for cont = 1:maxIter
       x1 = x0 - a*inv(h(x0))*g(x0);
    if (abs(max(x1-x0)) <= tol)
      x0 = x1;
      break
    endif
    x0 = x1;
  endfor
endfunction


function g = g(x)
  x1 = x(1);
  x2 = x(2);
  g = [4.*x1.*x2.^4+6.*x1-6.*x1.*x2.^2+39/4.*x2.^2-51/4-4.*x1.*x2+3.*x2;
       8.*x1^2.*x2.^3-6.*x1.^2.*x2+39/2.*x1.*x2-2.*x1.^2+3.*x1];
endfunction

function h = h(x)
    x1 = x(1);
    x2 = x(2);
    h = [4.*x2.^4-6.*x2.^2-4.*x2+6,16.*x1.*x2.^3-12.*x1.*x2+39/2.*x2-4.*x1+3;
        16.*x1.*x2.^3-12.*x1.*x2+39/2.*x2-4.*x1+3,24.*x1.^2.*x2.^2-6.*x1.^2+39/2.*x1];
end


function y = f(x)
  x1 = x(1);
  x2 = x(2);
  y = (x1.*x2.^2 - x1 + 2.25).^2 + (x1.*x2.^3 - x1 + 2.625).^2 + (x1.*x2 -x1 +1.5).^2;
endfunction
