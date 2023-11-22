addpath("../0.toolkit/m-files/", "../1.DLT_Calibration/", "../0.toolkit/m-files/aux_fun/", "../5.epipolar/");

M = 1+rand(3,10);

K = [-1000 0 300 ; 0 -1000 300 ; 0 0 1]

P1 = K*eye(3,4); 
P2 = K*camera( -10*rand(1,3)-1, [0 0 100*rand], [0 1 0 ] );

[K, RR , tt] = krt(P2);
RR  
tt./norm(tt)

m1 = proj(P1, M);
m2 = proj(P2, M);

[R, t] = relative_orientation_23(m2, m1, K, K)
