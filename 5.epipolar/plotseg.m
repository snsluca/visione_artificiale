function plotseg(line,xlim,ylim,color)
    %PLOTSEG plot a segment btw xlim(1) and ylim(2)
    % line is line(1)*x + line(2)*y + line(3) = 0

    % Author: Andrea Fusiello
    
    % vengono fatte delle approssimazioni, ma è solo per disegnare
    if line(1) == 0, line(1) = 1e-12; end
    if line(2) == 0, line(2) = 1e-12; end
    
    x =  [0 ;  -line(3)/line(1)];
    y =  [ -line(3)/line(2) ; 0];

    a = y(2)-y(1);
    b = x(1)-x(2);
    c = -x(1)*a-y(1)*b;
    
    if b == 0, b = 1e-12;  end
    
    y1 = bound(-a/b*xlim(1)-c/b,ylim);
    y2 = bound(-a/b*xlim(2)-c/b,ylim);
    
    plot(xlim, [y1, y2], 'LineWidth', 2, 'Color', color);
    
end


function y = bound(x,b)
    % return bounded value clipped between b(1) and b(2)
    y=min(max(x,b(1)),b(2));
end

