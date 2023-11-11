function [P, K] = calibSMZ(H)
    numV = length(H);
    S = duplication(3);

    L = [];
    for i = 1:numV
        L = [L; (kron(H{i}(:,2)', H{i}(:,1)'))*S;
                (kron(H{i}(:,1)', H{i}(:,1)') - kron(H{i}(:,2)', H{i}(:,2)'))*S];
    end

    [~, ~, V] = svd(L);
    B = reshape(S*V(:, end), 3, []);
    if trace(B)<0
        B = -B;
    end

    iK = diag([-1, -1, 1])*chol(B);

    K = inv(iK);
    K = K ./ K(3,3);

    for i = 1:numV
        A = iK * H{i};
        A = A/norm(A(:,1));

        R = [A(:,1:2), cross(A(:,1), A(:,2))];
        t = A(:,3);

        [U, ~, V] = svd(R);
        R = U*diag([1, 1, det(V'*U)])*V';

        if [0, 0, 1]*(-R'*t)<0
            R(:, 1:2) = -R(:,1:2);
            t = -t;
        end

        P{i} = K*[R, t];
    end
end
