addpath("../0.toolkit/m-files/", "../3.OPA/", "../5.epipolar/", "../1.DLT_Calibration/")

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
    1.4940    1.6989;
    3.0919    1.0096;
    %0.6715    1.5187;
    %2.8543    1.4300;
    %2.6376    0.3282
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
    0.4098    0.9221;
    2.0290    1.8366;
    %0.4878    0.5173;
    %1.2524    1.7947;
    %2.9013    1.0775
]';

%run("../1.DLT_Calibration/elaboration_krt.m");
run("../2.Sturm_Maybank_Zhang_calibration/elaboration.m");

K

P1 = K*[eye(3) zeros(3,1)]
[R, t] = relative_orientation_23(m2, m1, K, K)
P2 = K*[R t]

for i =1:size(m2,2)
MM(:,i) = classe_triangulation_23({P1, P2}, {m1(:,i), m2(:,i)})
end

m1 = proj(P1, MM);
m2 = proj(P2, MM);

I1 = imread('../5.epipolar/IMG_20231110_150716.jpg');
I2 = imread('../5.epipolar/IMG_20231110_150721.jpg');

subplot(1,2,1)
imshow(I1, []);
hold on
plot(m1(1,:), m1(2,:), 'o',"MarkerFaceColor", "yellow");
hold off
subplot(1,2,2)
imshow(I2, []);
hold on
plot(m2(1,:), m2(2,:), 'o',"MarkerFaceColor", "yellow");
hold off
