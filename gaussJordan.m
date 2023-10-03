
 function gaussJordan()
  clc
  A = [0.3 -0.2 10; 3 -0.1 -0.2;0.1 7 -0.3 ];
  b = [71.4;7.85;-19.3];
  [Aa] = pivoting(A,b);
  [Aa] = zeroing(Aa);
  Aa(:,end)
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
  pivoTot = size(Aa,1);
  ################ ZERANDO ABAIXO DOS PIVOS
  for i = 1:pivoTot
    pivot = Aa(i,i);
    norm = Aa(i,:)/pivot;
    Aa(i,:) = norm;
    for j = i+1:pivoTot
      Aa(j,:) = Aa(j,:) - Aa(j,i)*norm;
    endfor
  endfor
  ################ ZERANDO ACIMA DOS PIVOS
  for i = pivoTot:-1:1
    for j=i-1:-1:1
		Aa(j,:) = Aa(j,:) - Aa(j,i)*Aa(i,:);
	endfor
  endfor
 endfunction
