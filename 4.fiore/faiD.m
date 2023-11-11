function D = faiD(n)

    D = zeros(n*n, n);
    for i = 1:n
        D(1+(i-1)*(n+1),i) = 1;
    end

% si usa ad esempio come:
%V = rand(3,1)
%vec(diag(V))
%questo si ottiene ugualmente con: faiD(3)*V
