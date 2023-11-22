function F = ottopunti (m2, m1)
    n = size(m1, 2);
   
    m1 = [m1; ones(1,n)];
    m2 = [m2; ones(1,n)];

    A = [];

    for i=1:n
        A = [A; kron(m1(:,i)', m2(:,i)')];
    end

    [U, D, V] = svd(A);
    
    F = reshape(V(:, end),3,[]);
