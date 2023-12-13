syms a b c d e f x y;
equat = a.*x.^2+b.*x.*y+c.*y.^2+d.*x+e.*y+f;

jac =[
    diff(equat, a);
    diff(equat, b);
    diff(equat, c);
    diff(equat, d);
    diff(equat, e);
    diff(equat, f);
    ];

gr =[
    diff(equat, x);
    diff(equat, y);
    ].';

sams = (equat/norm(gr))^2;
sams_nonq = (equat/norm(gr));


jac_2 =[
    diff(sams_nonq, a);
    diff(sams_nonq, b);
    diff(sams_nonq, c);
    diff(sams_nonq, d);
    diff(sams_nonq, e);
    diff(sams_nonq, f);
    ];
