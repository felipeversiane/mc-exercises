
 function elimGauss()
  clc
  A = [0.780 0.563;0.913 0.659];
  b = [0.217;0.254];
  [Aa] = pivoting(A,b);
  [Aa] = zeroing(Aa);
  [Aa,x1] = structure(Aa);
  x1
  x = A\b
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
          f = Aa(j,i)/pivot;
          Aa(j,:) = Aa(j,:) - f*Aa(i,:);
        endif
      endfor
   endfor
  endfunction

  function [Aa,x1] = structure(Aa)
    x1 = zeros(size(Aa(:,1)));
    pivotMax = size(Aa,1);
    for i=pivotMax:-1:1
      pivot = Aa(i,i);
      if i == pivotMax
        x1(i) = Aa(i,end)/pivot;
        Aa(i-1:-1:1,i)=x1(i)*Aa(i-1:-1:1,i);
      else
        sub= sum(Aa(i,i+1:end-1));
        x1(i) = ((Aa(i,end)-sub)/Aa(i,i));
        if i > 1
          Aa(i-1:-1:1,i)= x1(i)*Aa(i-1:-1:1,i);
        endif
      endif
    endfor
  endfunction


  function s = sistem(x1,x2,x3)
    s = [0.780.*x1 + 0.563.*x2 - 0.217;
         0.913.*x1 + 0.659.*x2 - 0.254];
  endfunction
