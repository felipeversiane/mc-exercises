 function elimGauss()
  clc
  A = [20 5 -8 3 3;5 -3/2 4 1 3;-14 9 9 3 1; -3 10 20 30 20; -3 10 10 30 2];
  b = [32; -4; 3; 30; 10];
  [Aa] = pivoting(A,b);
  [Aa] = zeroing(Aa);
  [Aa,x1] = structure(Aa);
  Aa
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
      f = Aa(j,i)/pivot;
      Aa(j,:) = Aa(j,:) - f*Aa(i,:);
    end
  end

endfunction

function [Aa,x1] = structure(Aa)
  x1 = zeros(size(Aa,1),1);
endfunction

