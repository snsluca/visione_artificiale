addpath("../0.toolkit/m-files/", "../3.OPA/", "../4.fiore/", "../5.epipolar/", "../6.relative_triangulation/", "../1.DLT_Calibration/", "../7.triangulation_nonlin_fusiello/", "../0.toolkit/thirdparty/")

tmp = load('1702817288720_points.mat');
m1 = tmp.m';
tmp = load('1702817288728_points.mat');
m2 = tmp.m';
tmp = load('170281728873_points.mat');
m3 = tmp.m';

 run("../1.DLT_Calibration/elaboration_krt.m");
%run("../2.Sturm_Maybank_Zhang_calibration/elaboration.m");

if 1==1

method = 2;
switch method
    case 1
        P1 = K*[eye(3) zeros(3,1)]
        [R2, t2] = relative_orientation_23(m2, m1, K, K)
        [R2, t2] = relative_nonlin(R2, t2, m2, m1, K, K);
        P2 = K*[R2 t2]

        for i =1:size(m2,2)
        MM_12(:,i) = classe_triangulation_23({P1, P2}, {m1(:,i), m2(:,i)});
        end
        MM_12 = triang_nonlin_batch(MM_12, {P1, P2}, {m1, m2});

        [R3, t3] = exterior_lin(m3, MM_12, K);
        [R3, t3] = exterior_nonlin(R3, t3, m3, MM_12, K);
        P3 = K*[R3 t3]

        for i =1:size(m2,2)
        MM(:,i) = classe_triangulation_23({P1, P2, P3}, {m1(:,i), m2(:,i), m3(:,i)});
        end
        MM = triang_nonlin_batch(MM, {P1, P2, P3}, {m1, m2, m3});

    case 2
        P1 = K*[eye(3) zeros(3,1)]
        [R2, t2] = relative_orientation_23(m2, m1, K, K)
        [R2, t2] = relative_nonlin(R2, t2, m2, m1, K, K);
        P2 = K*[R2 t2]
        for i =1:size(m2,2)
        MM_12(:,i) = classe_triangulation_23({P1, P2}, {m1(:,i), m2(:,i)});
        end
        MM_12 = triang_nonlin_batch(MM_12, {P1, P2}, {m1, m2});

        P2 = K*[eye(3) zeros(3,1)]
        [R3, t3] = relative_orientation_23(m3, m2, K, K)
        [R3, t3] = relative_nonlin(R3, t3, m3, m2, K, K);
        P3 = K*[R3 t3]
        for i =1:size(m2,2)
        MM_23(:,i) = classe_triangulation_23({P2, P3}, {m2(:,i), m3(:,i)});
        end
        MM_23 = triang_nonlin_batch(MM_23, {P2, P3}, {m2, m3});

        [S, R, t] = opa23(MM_12, MM_23);
        P2 = K*[R2*R t2+t]
        P3 = K*[R3*R t3+t]

        for i =1:size(m2,2)
        MM(:,i) = classe_triangulation_23({P1, P2, P3}, {m1(:,i), m2(:,i), m3(:,i)});
        end
        MM = triang_nonlin_batch(MM, {P1, P2, P3}, {m1, m2, m3});
    otherwise
        disp('Please choose a three-view method.');
        return;
end
    mm1 = proj(P1, MM);
    mm2 = proj(P2, MM);
    mm3 = proj(P3, MM);
else
mm1 = m1;
mm2 = m2;
mm3 = m3;
end
I1 = imread('1702817288720.jpg');
I2 = imread('1702817288728.jpg');
I3 = imread('1702817288739.jpg');

figure(1)
subplot(2,2,1)
imshow(I1, []);
hold on
plot(m1(1,:), m1(2,:), 'o', "MarkerFaceColor", "green");
plot(mm1(1,:), mm1(2,:), 'o', "MarkerFaceColor", "yellow");
hold off
subplot(2,2,2)
imshow(I2, []);
hold on
plot(m2(1,:), m2(2,:), 'o', "MarkerFaceColor", "green");
plot(mm2(1,:), mm2(2,:), 'o',"MarkerFaceColor", "yellow");
hold off
subplot(2,2,3)
imshow(I3, []);
hold on
plot(m3(1,:), m3(2,:), 'o', "MarkerFaceColor", "green");
plot(mm3(1,:), mm3(2,:), 'o',"MarkerFaceColor", "yellow");
hold off
subplot(2,2,4)
plot3(MM(1,:), MM(2,:), MM(3,:), 'o',"MarkerFaceColor", "yellow");
