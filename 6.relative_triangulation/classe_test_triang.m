clear
clc

M = 1+rand(3,10)

K = [1000 0 300; 0 1000, 300; 0 0 1];

P1 = K*eye(3,4);

t = randn(3,1);
t = t./norm(t);
R = eul(randn(1,3));

P2 = K*[R, t];

m1 = proj(P1,M);
m2 = proj(P2,M);


for i =1:10
MM(:,i) = triangulation_23({P1, P2}, {m1(:,i), m2(:,i)});
end

MM
