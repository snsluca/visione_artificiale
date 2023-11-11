function P = resect (m, M)
%    assert(N >= 6); % assert numero di punti
%    assert(size(M, 1) == 3); % assert dimensionale
%    assert(size(m, 1) == 2); % assert dimensionale
%    assert(rank(M) == 3); %assert della non coplanarietà dei punti
    
    M = [M; ones(1, size(M, 2))];
    m = [m; ones(1, size(m, 2))];
    
    A = [];
    
    for i=1:size(m, 2)
        A = [A; kron(M(:, i)', skew(m(:,i)))]; %M(:,i) = tutte le righe della iesima colonna
    end
    
    [U, D, V] = svd(A);
    P = reshape(V(:, end), 3, []); %[] significa "quello che ci vuole"
end
