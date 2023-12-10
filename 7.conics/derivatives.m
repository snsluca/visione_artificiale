syms a b c d e f x y;
equat = a.*x.^2+b.*x.*y+c.*y.^2+d.*x+e.*y+f;

gr =[
    diff(equat, a);
    diff(equat, b);
    diff(equat, c);
    diff(equat, d);
    diff(equat, e);
    diff(equat, f);
    ];

sams = (equat/norm(gr))^2;

