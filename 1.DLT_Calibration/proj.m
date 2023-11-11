function m = proj(P, M)
    N = size(M,2);
    M = [M; ones(1,N)];
    m = P * M;
    m = m ./ repmat(m(3,:),3,1);
    m(3,:) = [];
end


