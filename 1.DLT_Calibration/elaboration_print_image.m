run("elaboration_krt.m");

P
K
R
t
C

I = imread('1697649095251.jpg');

imshow(I, []);
hold on;
plot(m(1,:), m(2,:), 'o', "MarkerFaceColor", "green");

m2 = proj(P, M);
plot(m2(1,:), m2(2,:), 'o', "MarkerFaceColor", "yellow");
