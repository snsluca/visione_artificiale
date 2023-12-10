addpath("../0.toolkit/m-files/", "../3.OPA/", "../1.DLT_Calibration/")

topolino = 0;

run("points.m");

run("../1.DLT_Calibration/elaboration_krt.m");

%nota: se io scambio qui m1 ed m2, devo scambiare anche dove proietto le rette epipolari!
%così proietto in immagine 2 le rette epipolari calcolate con F*m1;
%se li scambio, proietto in 1 le rette epipolari calcolate con F*m2
F = fund_lin(m2, m1);

avgval_F = calc_average(m1, m2, F);
