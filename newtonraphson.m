function newtonraphson()
  maxInt = 1000;
  x0 = [0.5;1;0];
  tol = 1e-5;
  allX = zeros(maxInt,2);
  
  for cont = 1:maxInt
    x1 = x0 - inv(jacob(x0)).*sistem(x0)
    allX(cont,:) = x1;
    if max(abs(x1-x0)) <= tol
      break
    endif
    x0=x1;
    hold on
    pause(0.3);
  endfor
  allX = allX(1:cont, :);
  sprintf("Levou %i para achar a raiz",cont);
endfunction

function s = sistem(x0) 
  x = x0(1);
  y = x0(2);
  z = x0(3);
  s = [6.*x -2.*y+exp(z) - 2; sin(x) - y + z ; sin(x) + 2.*y + 3.*z - 1];
endfunction

function j = jacob(x0)
  x = x0(1);
  y = x0(2);
  z = x0(3);
  j = [6,-2,exp(z);cos(x),-1,1;cos(x),2,3]; 
endfunction






