% Solves nonlinear orientation problem.
function [P2, R2, t2] = calcorientation(m2, m1, K)
    [R2, t2] = relative_orientation_23(m2, m1, K, K)
    [R2, t2] = relative_nonlin(R2, t2, m2, m1, K, K);
    P2 = K*[R2 t2]
end
