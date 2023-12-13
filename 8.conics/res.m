function [R, J] = res(C, x, y)
    a = C(1);
    b = C(2);
    c = C(3);
    d = C(4);
    e = C(5);
    f = C(6); 
    eq = @(xx,yy) (a.*x.^2 + b.*x.*y + d.*x + c.*y.^2 + e.*y + f)./(abs(d + 2.*a.*x + b.*y).^2 + abs(e + b.*x + 2.*c.*y).^2).^(1./2);

    x = x(:);
    y = y(:);
    jac = [
    x.^2./(abs(d + 2.*a.*x + b.*y).^2 + abs(e + b.*x + 2.*c.*y).^2).^(1./2) - (abs(d + 2.*a.*x + b.*y).*(2.*conj(x).*(d + 2.*a.*x + b.*y) + 2.*x.*(conj(d) + conj(b).*conj(y) + 2.*conj(a).*conj(x))).*(a.*x.^2 + b.*x.*y + d.*x + c.*y.^2 + e.*y + f))./(2.*(abs(d + 2.*a.*x + b.*y).^2 + abs(e + b.*x + 2.*c.*y).^2).^(3./2).*((conj(d) + conj(b).*conj(y) + 2.*conj(a).*conj(x)).*(d + 2.*a.*x + b.*y)).^(1./2)) ...
    (x.*y)./(abs(d + 2.*a.*x + b.*y).^2 + abs(e + b.*x + 2.*c.*y).^2).^(1./2) - (((abs(d + 2.*a.*x + b.*y).*(conj(y).*(d + 2.*a.*x + b.*y) + y.*(conj(d) + conj(b).*conj(y) + 2.*conj(a).*conj(x))))./((conj(d) + conj(b).*conj(y) + 2.*conj(a).*conj(x)).*(d + 2.*a.*x + b.*y)).^(1./2) + (abs(e + b.*x + 2.*c.*y).*(x.*(conj(e) + conj(b).*conj(x) + 2.*conj(c).*conj(y)) + conj(x).*(e + b.*x + 2.*c.*y)))./((conj(e) + conj(b).*conj(x) + 2.*conj(c).*conj(y)).*(e + b.*x + 2.*c.*y)).^(1./2)).*(a.*x.^2 + b.*x.*y + d.*x + c.*y.^2 + e.*y + f))./(2.*(abs(d + 2.*a.*x + b.*y).^2 + abs(e + b.*x + 2.*c.*y).^2).^(3./2)) ...
    y.^2./(abs(d + 2.*a.*x + b.*y).^2 + abs(e + b.*x + 2.*c.*y).^2).^(1./2) - (abs(e + b.*x + 2.*c.*y).*(2.*y.*(conj(e) + conj(b).*conj(x) + 2.*conj(c).*conj(y)) + 2.*conj(y).*(e + b.*x + 2.*c.*y)).*(a.*x.^2 + b.*x.*y + d.*x + c.*y.^2 + e.*y + f))./(2.*(abs(d + 2.*a.*x + b.*y).^2 + abs(e + b.*x + 2.*c.*y).^2).^(3./2).*((conj(e) + conj(b).*conj(x) + 2.*conj(c).*conj(y)).*(e + b.*x + 2.*c.*y)).^(1./2)) ...
    x./(abs(d + 2.*a.*x + b.*y).^2 + abs(e + b.*x + 2.*c.*y).^2).^(1./2) - (abs(d + 2.*a.*x + b.*y).*(a.*x.^2 + b.*x.*y + d.*x + c.*y.^2 + e.*y + f).*(d + conj(d) + conj(b).*conj(y) + 2.*a.*x + b.*y + 2.*conj(a).*conj(x)))./(2.*(abs(d + 2.*a.*x + b.*y).^2 + abs(e + b.*x + 2.*c.*y).^2).^(3./2).*((conj(d) + conj(b).*conj(y) + 2.*conj(a).*conj(x)).*(d + 2.*a.*x + b.*y)).^(1./2)) ...
    y./(abs(d + 2.*a.*x + b.*y).^2 + abs(e + b.*x + 2.*c.*y).^2).^(1./2) - (abs(e + b.*x + 2.*c.*y).*(e + conj(e) + conj(b).*conj(x) + 2.*conj(c).*conj(y) + b.*x + 2.*c.*y).*(a.*x.^2 + b.*x.*y + d.*x + c.*y.^2 + e.*y + f))./(2.*(abs(d + 2.*a.*x + b.*y).^2 + abs(e + b.*x + 2.*c.*y).^2).^(3./2).*((conj(e) + conj(b).*conj(x) + 2.*conj(c).*conj(y)).*(e + b.*x + 2.*c.*y)).^(1./2)) ...
    1./(abs(d + 2.*a.*x + b.*y).^2 + abs(e + b.*x + 2.*c.*y).^2).^(1./2)
];

    %jac = [conj(x).^2, conj(x).*conj(y), conj(y).^2, conj(x), conj(y), ones(length(x),1)];
    R = sum(eq(x,y));
    J=jac;
