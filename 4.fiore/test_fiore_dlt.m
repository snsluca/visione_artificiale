addpath("../0.toolkit/m-files/", "../3.OPA/", "../1.DLT_Calibration/");

elaboration;
[K, R, t] = krt(P);

R
t

[R1,t1]  = fiore(m, M, K);

R1
t1
