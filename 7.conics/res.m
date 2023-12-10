function [R, J] = res(C, x, y)
    a = C(1);
    b = C(2);
    c = C(3);
    d = C(4);
    e = C(5);
    f = C(6); 
%    eq = @(xx,yy) (a.*xx.^2 + b.*xx.*yy + d.*xx + c.*yy.^2 + e.*yy + f)./(abs(xx.*yy).^2 + abs(xx).^4 + abs(xx).^2 + abs(yy).^4 + abs(yy).^2 + 1).^(1/2);
    eq = @(xx,yy) 0.5*(a.*xx.^2 + b.*xx.*yy + d.*xx + c.*yy.^2 + e.*yy + f).^2./(abs(xx.*yy).^2 + abs(xx).^4 + abs(xx).^2 + abs(yy).^4 + abs(yy).^2 + 1);
    grad = [conj(x).^2, conj(x).*conj(y), conj(y).^2, conj(x), conj(y), ones(length(x),1)];
    
    R = sum(eq(x,y));
    J=grad;
