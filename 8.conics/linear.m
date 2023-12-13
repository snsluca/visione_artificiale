addpath("../0.toolkit/thirdparty/", "../0.toolkit/m-files/")
% ax^2 + bxy + cy^2 + dx + ey + f = 0
aa = 1;
bb = 2;

alpha = 0.2;
n = 1000;
phi = (1:n)./n*(2*pi);
phi = phi';
x = aa*cos(phi)+alpha*rand(size(phi));
y = bb*sin(phi)+alpha*rand(size(phi));

centro = [0.5 0.5];
x = x+centro(1);
y = y+centro(2);

theta = pi/4;
R = [cos(theta) -sin(theta); sin(theta) cos(theta)];

tmp = [x' ; y'];
tmp = R*tmp;
x = tmp(1, :)';
y = tmp(2, :)';

mio = 1;

%run("rand_nums.m");

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

    C = [C ; 1]
end

figure(1)
plot(x,y, 'o', 'MarkerSize', 2);
axis equal;
grid on;
hold on;
shg;
cmap = colormap(lines);
if mio == 0
    syms u v real
    gca = ezplot([u;v;1]'* C *[u;v;1], [-aa aa -bb bb] + [-1 1 -1 1] );
else
    C1 = C;
    a1 = C1(1);
    b1 = C1(2);
    c1 = C1(3);
    d1 = C1(4);
    e1 = C1(5);
    f1 = C1(6); 
    eq1 = @(xx,yy) a1.*xx.^2+b1.*xx.*yy+c1.*yy.^2+d1.*xx+e1.*yy+f1;
    gca = fimplicit(eq1, [-aa aa -bb bb] + [-1 1 -1 1]);
    set(gca,'Color', cmap(3,:), 'LineWidth', 2, 'LineStyle', ':');
    
    C2 = simpleGN(@(CC) res(CC,x,y), C1);
    a2 = C2(1);
    b2 = C2(2);
    c2 = C2(3);
    d2 = C2(4);
    e2 = C2(5);
    f2 = C2(6); 
    eq2 = @(xx,yy) a2.*xx.^2+b2.*xx.*yy+c2.*yy.^2+d2.*xx+e2.*yy+f2;
    gca = fimplicit(eq2, [-aa aa -bb bb] + [-1 1 -1 1]);
    set(gca,'Color', cmap(2,:), 'LineWidth', 2, 'LineStyle', ':');

    disp('Non-refined residual');
    [R1, ~] = res(C1,x,y)
    disp('Refined residual');
    [R2, ~] = res(C2,x,y)
end
hold off
