function [S, R, t] = opa23(D, M)
    n = size(D, 2);
    J = eye(n)-ones(n)/n;
    [U, S, V] = svd(D*J*M');
    R = U*diag([1, 1, det(V'*U)])*V';
    S = trace(D*J*M'*R')/trace(M*J*M');
    t = mean(D/S - R*M, 2);
end
