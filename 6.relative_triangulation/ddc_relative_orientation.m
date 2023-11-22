function [R,t] = relative_orientation(m2,m1,K2,K1)
n = size(m1,2);
% Homogenous coordinates
m1 = [m1; ones(1,n)];
m2 = [m2; ones(1,n)];
% NIC: Normalized Image Coordinates
m1 = K1\m1;
m2 = K2\m2;
% eight_points with an essential instead of fundamental setup, also
% coorinates are back to cartesian
E = eight_points(m2(1:2,:),m1(1:2,:));

S1 = skew([0 0 1]');
R1 = eul([0 0 pi/2]);
[U, ~, V] = svd(E);
for k = 1:4
  S = (-1)^k * U * S1 * U';
  t = [S(3,2) S(1,3) S(2,1)]';
  if k == 3
    R1 = R1';
  end
  R = det(U * V') * U * R1 * V';
  z = [m2(:,1),-R*m1(:,1)]\t;
  if z(1)>0 && z(2)>0
    break
  end
end