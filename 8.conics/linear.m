addpath("../0.toolkit/thirdparty/", "../0.toolkit/m-files/")
%generic conic equation
%ax^2 + bxy + cy^2 + dx + ey + f = 0

%% Data generation
%parameters
aa = 1;
bb = 2;
alpha = 0.2;
n = 1000;
phi = (1:n)./n*(2*pi);
phi = phi';
%base ellipse
x = aa*cos(phi)+alpha*rand(size(phi));
y = bb*sin(phi)+alpha*rand(size(phi));
%translation
centro = [0.5 0.5];
x = x+centro(1);
y = y+centro(2);
%rotation
theta = pi/4;
R = [cos(theta) -sin(theta); sin(theta) cos(theta)];

tmp = [x' ; y'];
tmp = R*tmp;
x = tmp(1, :)';
y = tmp(2, :)';

%% Elaboration settings
grafici = 1;
sing = 0;

%% Elaboration
    
if (sing == 1)
    %%% SVD strategy
    A = [x.^2 x.*y y.^2 x y ones(length(x), 1)];
    [~, ~, V] = svd(A);
    %The last column of V represents the "optimal" kernel base, which enables
    %us to solve the problem of least squares optimally. As a matter of fact, 
    %this column corresponds to the smaller singular value of S ([U, S, V] = 
    % = svd(A);
    %see least_squares_fitting_ellipse_circles_gander.pdf for more info.
    C = V(:,6);
else
    %%% f=1 strategy
    %y = Ax
    %In order to avoid the trivial solution (C equals all zero),
    %we set f = 1 and then solve the linear system of equation.
    %see direct_linear_least_squares_fitting_of_an_ellipse.pdf
    A = [x.^2 x.*y y.^2 x y];
    b = -ones(length(x), 1);
    %Solution calculated by following:
    %see The_Method_of_Least_Squares.pdf
    C = (A'*A)^-1*A'*b;
    C = [C ; 1]
end

%% Plot graphs
if(grafici == 1)
    figure(1)
    plot(x,y, 'o', 'MarkerSize', 2);
    axis equal;
    grid on;
    hold on;
    shg;
    cmap = colormap(lines);
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
    hold off
end
