addpath("../0.toolkit/m-files/", "../1.DLT_Calibration/");

M = rand(3, 12);

K = [1000 0 300; 0 1000 300; 0 0 1];
P1 = K*camera([-1 -1 -1], [0 0 85], [0 1 0]);
P2 = K*camera([-10 -1 -1], [0 0 98], [0 1 0]);

%sono due punti omologhi (lo stesso punto proiettato da due camere diverse)
m1 = proj(P1, M);
m2 = proj(P1, M);

F = ottopunti(m2, m1);

%come facciamo a sapere che ha senso? Controlliamo che la F abbia senso rispetto ai suoi stessi punti:
calc_average(m1, m2, F)

E = K'*F*K
