function newton-raphson()
  maxInt = 100;
  xl = -200;
  xu = 500;
  yl = -100;
  yu = 300;
  px = 1;
  py = 1;
  
  x0 = [0;0];
  tol = 1e-5;
  
  allX = zeros(maxInt,2);
  
  for cont = 1:maxInt
    x1 = x0 - inv(dsistem(x0))*sistem(x0)
    allX(cont,:) = x1;
    if max(abs(x1-x0)) <= tol
      break
    endif
    x0=x1;
    hold on;
    pause(0.3);
  endfor
  allX = allX(1:cont, :);
  plotInt(xl,xu,yl,yu,px,py,allX);
endfunction

function y = sistem(x) 
  x1 = x(1);
  x2 = x(2);
  y = [x1.^3+x2.^2 + 3;x1.^2+ 3.*x2 + 18];
endfunction

function j = dsistem(x)
  x1 = x(1);
  x2 = x(2);
  dy = [,;,]; 
endfunction

function plotInt(xl,xu,yl,yu,px,py,allX)
  interx = xl:px:xu;
  intery = yl:py:yu;
  interz = zeros(length(interx),length(intery),2);
  i=1;
  for x = interx
    j=1;
    for y = intery
      interz(i,j,:) = sistem([x;y]);
      j = j + 1 ;
    endfor
    i = i + 1;
  endfor
  for cont = 1:length(allX)
    posX(todosX(cont,1));
    posY(todosX(cont,2));
    
    figure(1);
    
    subplot(2,1,1);
    surf(interx,intery,interz(: , : , 1));
    hold on;
    posZ = sistema([posX,posY]);
    plot3(posX,posY,posZ(1),'markersize',20,'marker','o','markerfacecolor','m','color','k','linewidth',3);
    
    subplot(2,1,2);
    title(sprintf("Iteracao %i"),cont);
    surf(interx,intery,interz(: , : , 2));
    hold on;
    plot3(posX,posY,posZ(2),'markersize',20,'marker','o','markerfacecolor','m','color','k','linewidth',3);
    gca(set,'fontsize',12);
   endfor
endfunction




