addpath("../0.toolkit/m-files/aux_fun/")

%amplifies/reduces effect of noise
amp = 0.01;

M = rand(3, 10)+amp*(randn(3,10));
S = abs(randn+amp*(randn))
t = randn(3, 1)+amp*(randn(3,1))
R = eul(randn(1,3))+amp*(randn(1,3))
D = S*(R*M+t);

[S1, R1, t1] = opa23(D, M)
