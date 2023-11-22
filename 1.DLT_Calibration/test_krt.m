addpath("../0.toolkit/m-files/", "../0.toolkit/m-files/aux_fun/");

K = [-1000 0 300; 0 -1000, 300; 0 0 1]
t = randn(3,1);
t = t./norm(t)
R = eul(randn(1,3))

P = K*[R t];

[KK, RR, tt] = krt(P)
