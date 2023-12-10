addpath("../0.toolkit/thirdparty/")
% ax^2 + bxy + cy^2 + dx + ey + f = 0
aa = 6;
bb = 4;

n = 100;
phi = (1:n)./n*(2*pi);
phi = phi';
x = aa*cos(phi)+0.5*rand(size(phi));
y = bb*sin(phi)+0.5*rand(size(phi));

mio = 1;

if mio == 0
    m = [x';y';ones(1,n)];
    L = [];
    for i = 1: size(m,2)
        L = [L; kron( m(:,i)' , m(:,i)') ];
    end
    [~,~,V] = svd(L*duplication(3));
    C = reshape(duplication(3)*V(:,end),3,3)
else
    %y = Ax
    %In order to avoid the trivial solution (C equals all zero),
    %we set f = 1 and then solve the linear system of equation.
    %see:
    %-- https://scipython.com/blog/direct-linear-least-squares-fitting-of-an-ellipse/
    A = [x.^2 x.*y y.^2 x y];
    b = -ones(length(x), 1);
    %Solution calculated by following:
    %-- https://textbooks.math.gatech.edu/ila/least-squares.html#:~:text=So%20a%20least%2Dsquares%20solution,difference%20b%20%E2%88%92%20Ax%20is%20minimized.
    C = (A'*A)^-1*A'*b;
end

figure(1)
plot(x,y, 'o');
axis equal;
grid on;
hold on;
shg;
cmap = colormap(lines);
if mio == 0
    syms u v real
    gca = ezplot([u;v;1]'* C *[u;v;1], [-aa aa -bb bb] + [-1 1 -1 1] );
else
    a = C(1);
    b = C(2);
    c = C(3);
    d = C(4);
    e = C(5);
    f = 1;
    eq = @(xx,yy) a.*xx.^2+b.*xx.*yy+c.*yy.^2+d.*xx+e.*yy+f;
    gca = fimplicit(eq, [-aa aa -bb bb] + [-1 1 -1 1]);
    %gca = ezplot(eq, [-aa aa -bb bb] + [-1 1 -1 1] );
end

set(gca,'Color', cmap(1,:), 'LineWidth', 1);
hold off;
