addpath("../0.toolkit/m-files/", "../3.OPA/", "../1.DLT_Calibration/")

m1 =  1.0e+03 * [ 
    1.4914    1.6023;
    0.9457    0.5423;
    2.4026    0.1820;
    3.1336    0.9313;
    1.7237    1.0331;
    1.7055    0.5083;
    2.6558    0.6885;
    2.1258    0.9156;
    1.2721    0.7772;
    2.3634    0.3621;
    2.0893    0.5997;
    2.6167    0.8739;
]';

m2 =  1.0e+03 * [ 
    0.4000    0.8269;
    1.3217    0.1350;
    2.7237    0.7224;
    2.0240    1.7537;
    1.0945    0.7250;
    1.7525    0.4770;
    2.0423    1.1846;
    1.4026    0.9130;
    1.2224    0.3908;
    2.3713    0.7851;
    1.8308    0.7485;
    1.7290    1.2394;
]';

run("../1.DLT_Calibration/elaboration_krt.m");

%nota: se io scambio qui m1 ed m2, devo scambiare anche dove proietto le rette epipolari!
%così proietto in immagine 2 le rette epipolari calcolate con F*m1;
%se li scambio, proietto in 1 le rette epipolari calcolate con F*m2
F = ottopunti(m1, m2);

avgval_F = calc_average(m1, m2, F);

