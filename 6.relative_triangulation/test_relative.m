addpath("../0.toolkit/m-files/", "../1.DLT_Calibration/", "../0.toolkit/m-files/aux_fun/", "../5.epipolar/");

M = 1+rand(3,10);

K = [1000 0 300 ; 0 1000 300 ; 0 0 1]
P2 = K*eye(3,4); 
P2(1,4) = 10;

P1 = K*eye(3,4); 

t = randn(3,1);
t = t./norm(t)
R = eul(randn(1,3))

P2 = K*[R t];

m1 = proj(P1, M);
m2 = proj(P2, M);

[RR, tt] = relative_orientation_23(m2, m1, K, K)
