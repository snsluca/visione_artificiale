%% Two views reconstruction
close all
clear

addpath("../0.toolkit/m-files/", "../0.toolkit/m-files/aux_fun/", "../0.toolkit/thirdparty/")
%% input 

% Compute (load) homologous points  m1 and m2
load export

% Intrinsic parameters from calibration
%K =  [2864.8, 0, 636.7; 0, 2864.8, 931.9; 0,0,1];
K

Im{1} = imread('1700683504527.jpg');
Im{2} = imread('1700683504539.jpg');

%%

% Relative orientation
[R,t] = relative_lin(m2, m1, K, K);
[R,t] = relative_nonlin(R, t ,m2, m1, K, K);

% Canonical camera pair
PPM{1} = K*[eye(3),zeros(3,1)];
PPM{2} = K*[R,t];

% Triangulation
M_out = triang_lin_batch(PPM, {m1,m2});
M_out = triang_nonlin_batch(M_out, PPM, {m1,m2});
% Done

% Print and plot
M_out(:,end)=[];
figure, plot3(M_out(1,:), M_out(2,:), M_out(3,:),'.k');
axis equal

figure, imshow(Im{1},[],'InitialMagnification' , 30); hold on
plot(m1(1,:), m1(2,:),'or')
m_proj = htx( PPM{1} , M_out);
plot(m_proj(1,:), m_proj(2,:),'.b')

figure, imshow(Im{2},[],'InitialMagnification' , 30); hold on
plot(m2(1,:), m2(2,:),'or')
m_proj = htx( PPM{2} , M_out);
plot(m_proj(1,:), m_proj(2,:),'.b')


