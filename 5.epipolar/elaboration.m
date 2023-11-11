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

F = ottopunti(m2, m1)

calc_average(m1, m2, F)

homom1 = [m1; ones(1, size(m1, 2))];
homom2 = [m2; ones(1, size(m2, 2))];

I1 = imread('IMG_20231110_150716.jpg');
I2 = imread('IMG_20231110_150721.jpg');

subplot(1,2,1)
imshow(I1, []);
hold on;
plot(m1(1,:), m1(2,:), 'o');
hold off

subplot(1,2,2)
imshow(I2, []);
hold on;
plot(m2(1,:), m2(2,:), 'o');
%y = [m1

for i=1:size(homom1, 2)
    lin = F*homom1(:,i)
    %retta nel formato: lin(1)*x + lin(2)*y + lin(3) = 0 , quindi : -(lin(1)*x+lin(3))/lin(2);
    
    x(1,1) = 0;
    x(1,2) = size(I2, 2);
    y(2,1) = -(lin(1)*x(1,1)+lin(3))/lin(2);
    y(2,2) = -(lin(1)*x(1,2)+lin(3))/lin(2);
    
    plot(x, y, '-x');
end
hold off
