function [R,t] = classe_relative_orientation_23(m2, m1, K2, K1)

n = size(m1,2);
m1 = [m1; ones(1,n)];
m2 = [m2; ones(1,n)];

m1 = inv(K1)*m1; %NIC
m2 = inv(K2)*m2; %NIC

E = ottopunti(m2(1:2,:), m1(1:2,:));

S1 = skew([0 0 1]);
R1 = eul([ 0 0 pi/2]);

[U, ~, V] = svd(E);


for k = 1:4

    S = (-1)^k * U*S1*U';
    t = [S(3,2); S(1,3); S(2,1)];
    t = t./norm(t);

    if k == 3
        R1 = R1';
    end

    R = det(U*V')*U*R1*V';

    z = [ m2(:,1), -R*m1(:,1)] \t;

    if z(1) > 0 && z(2) > 0 break;

    end
   
end


