 function elimGauss()
  clc
  A = [0.780 0.563;0.913 0.659];
  b = [0.217;0.254];
  [Aa] = pivoting(A,b);
  [Aa] = zeroing(Aa);
  [Aa,x1] = structure(Aa);
  x1
 endfunction

 function [Aa] = pivoting(A,b)

   pivoTot = size(A,1);
   Aa = [A b];
  for count = 1:pivoTot-1
     col = Aa(count:end,count);
     [maxValue, maxIndex] = max(abs(col));
     maxIndex = count + maxIndex - 1;
     aux = Aa(count,:);
     Aa(count,:) = Aa(maxIndex, :);
     Aa(maxIndex,:) = aux;
  endfor
 endfunction

 function [Aa] = zeroing(Aa)

  [n,m] = size(Aa);
  for i=1:n-1
    pivot = Aa(i,i);
    for j=i+1:n
      if j <= n
        fator = Aa(j,i)/pivot;
        Aa(j,i) = 0;
      end
    end
  end

  endfunction

  function [Aa,x1] = structure(Aa)
    n = size(Aa,1);
    x1 = zeros(n,1);
    x1(n) = Aa(n,n);
    for i = n-1:-1:1
      soma = 0;
      for j = i+1:n
        soma = soma + Aa(i,j) * x1(j);
      end
      x1(i) = Aa(i,n) - soma;
    end
   endfunction

  function s = sistem(x1,x2)
    s = [0.780.*x1 + 0.563.*x2 - 0.217;
         0.913.*x1 + 0.659.*x2 - 0.254];
  endfunction

