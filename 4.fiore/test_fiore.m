addpath("../0.toolkit/m-files/", "../3.OPA/", "../1.DLT_Calibration/");

t = randn(3, 1);
K = [1000 0 300; 0 1000 300; 0 0 1];
P1 = K*camera([-1 -1 -1], [0 0 100], [0 1 0]);%questa camera genera punti davanti a sè 
M = rand(3, 10);
m = proj(P1, M);

[R2, t2] = fiore(m, M, K)
