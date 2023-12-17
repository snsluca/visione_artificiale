addpath("../0.toolkit/m-files/", "../3.OPA/", "../5.epipolar/", "../1.DLT_Calibration/", "../7.triangulation_nonlin_fusiello/", "../0.toolkit/thirdparty/")

topolino = 0;

run("../5.epipolar/points.m");

 run("../1.DLT_Calibration/elaboration_krt.m");
%run("../2.Sturm_Maybank_Zhang_calibration/elaboration.m");

K

P2 = K*[eye(3) zeros(3,1)]
[R, t] = relative_orientation_23(m1, m2, K, K)
[R,t] = relative_nonlin(R, t, m1, m2, K, K);
P1 = K*[R t]

for i =1:size(m2,2)
MM(:,i) = classe_triangulation_23({P1, P2}, {m1(:,i), m2(:,i)});
end
MM = triang_nonlin_batch(MM, {P1, P2}, {m1,m2});

MM

mm1 = proj(P1, MM);
mm2 = proj(P2, MM);

if topolino == 1 
I1 = imread('IMG_20231110_150716.jpg');
I2 = imread('IMG_20231110_150721.jpg');
else
I1 = imread('1700683504527.jpg');
I2 = imread('1700683504539.jpg');

%I1 = rgb2gray(imread('1700683504527.jpg'));
%I2 = rgb2gray(imread('1700683504539.jpg'));
%I1 = rgb2gray(imread('1702719956145.jpg'));
%I2 = rgb2gray(imread('1702719956160.jpg'));
I1 = rgb2gray(imread('1702817288720.jpg'));
I2 = rgb2gray(imread('1702817288728.jpg'));
end

figure(1)
subplot(1,2,1)
imshow(I1, []);
hold on
plot(m1(1,:), m1(2,:), 'o', "MarkerFaceColor", "green");
plot(mm1(1,:), mm1(2,:), 'o', "MarkerFaceColor", "yellow");
hold off
subplot(1,2,2)
imshow(I2, []);
hold on
plot(m2(1,:), m2(2,:), 'o', "MarkerFaceColor", "green");
plot(mm2(1,:), mm2(2,:), 'o',"MarkerFaceColor", "yellow");
hold off

figure(2)
plot3(MM(1,:), MM(2,:), MM(3,:), 'o',"MarkerFaceColor", "yellow");
