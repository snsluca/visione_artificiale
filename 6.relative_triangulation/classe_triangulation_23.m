function M = classe_triangulation_23(P,m)

L = [];
for j=1:length(P)
    L = [L;skew([m{j};1])*P{j}];
end

[~, ~, V] = svd(L);

M = V(:, end)./V(end, end);

M = M(1:3);
