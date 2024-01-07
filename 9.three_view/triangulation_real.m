addpath("../0.toolkit/m-files/", "../3.OPA/", "../4.fiore/", "../5.epipolar/", "../6.relative_triangulation/", "../1.DLT_Calibration/", "../7.triangulation_nonlin_fusiello/", "../0.toolkit/thirdparty/")

%% loading saved image poins
tmp = load('1702817288720_points.mat');
m1 = tmp.m';
tmp = load('1702817288728_points.mat');
m2 = tmp.m';
tmp = load('170281728873_points.mat');
m3 = tmp.m';

 run("../1.DLT_Calibration/elaboration_krt.m");
%run("../2.Sturm_Maybank_Zhang_calibration/elaboration.m");

if 1==1
method = 3;
switch method
    case 1
        P1 = K*[eye(3) zeros(3,1)]
        [P2, R2, t2] = calcorientation(m2, m1, K)
        
        MM_12 = calctriangulation({P1, P2}, {m1, m2});

        [R3, t3] = exterior_lin(m3, MM_12, K);
        [R3, t3] = exterior_nonlin(R3, t3, m3, MM_12, K);
        P3 = K*[R3 t3]

        MM = calctriangulation({P1, P2, P3}, {m1, m2, m3});

    case 2
        P1 = K*[eye(3) zeros(3,1)]
        [P2, R2, t2] = calcorientation(m2, m1, K)
        MM_12 = calctriangulation({P1, P2}, {m1, m2});

        P2 = K*[eye(3) zeros(3,1)]
        [P3, R3, t3] = calcorientation(m3, m2, K)
        MM_23 = calctriangulation({P2, P3}, {m2, m3});

        %[S, R, t] = opa23(MM_23, MM_12);
        [R, t, S] = opa(MM_23, MM_12);
        MM = (MM_12 + MM_23)./2;
%       tmp = S*(R*MM_12+t);
%       MM = (MM_12 + tmp)./2;
        
%       figure(2)
%       hold on
%       plot3(MM_12(1,:), MM_12(2,:), MM_12(3,:), 'o',"MarkerFaceColor", "blue");
%       plot3(MM_23(1,:), MM_23(2,:), MM_23(3,:), 'o',"MarkerFaceColor", "yellow");
%       plot3(tmp(1,:), tmp(2,:), tmp(3,:), 'o',"MarkerFaceColor", "green");
%       hold off
        %P2 = K*[R t]
        %P3 = K*[R*R3 t+t3]
        %for i =1:size(m2,2)
        %MM(:,i) = classe_triangulation_23({P1, P2, P3}, {m1(:,i), m2(:,i), m3(:,i)});
        %end
        %MM = triang_nonlin_batch(MM, {P1, P2, P3}, {m1, m2, m3});

    case 3
        P11 = K*[eye(3) zeros(3,1)]
        [P21, R21, t21] = calcorientation(m2, m1, K)
        MM_21 = calctriangulation({P11, P11}, {m1, m2});

        P22 = K*[eye(3) zeros(3,1)]
        [P32, R32, t32] = calcorientation(m3, m2, K)
        MM_32 = calctriangulation({P22, P32}, {m2, m3});
        
        [P31, R31, t31] = calcorientation(m3, m1, K)
        MM_31 = calctriangulation({P11, P31}, {m1, m3});

        A = [0 1 1; 1 0 1; 1 1 0];
        
        ide = eye(3,3);
        Z = [ide  R21' R31';
             R21  ide  R32';
             R31  R32  ide ];
        R = rotation_synch(Z,A);

        B = [1 0 1; 1 1 0; 0 1 1];

        u21 = R2'*t21;
        u32 = R3'*t32;
        u31 = R3'*t31;
        U = [u21 u32 u31];

        T = translation_synch(U,B)

        P1 = K*[R{1} T{1}];
        P2 = K*[R{2} T{2}];
        P3 = K*[R{3} T{3}];

        MM = calctriangulation({P1, P2, P3}, {m1, m2, m3});

    otherwise
        disp('Please choose a valid three-view method.');
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

%% plots
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
