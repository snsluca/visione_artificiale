function F = fund_lin(m2, m1)
    %condioning
    [T1, m1] = precond(m1);
    [T2, m2] = precond(m2);

    F = ottopunti(m2, m1);
    [U, D, V] = svd(F);

    %singularity forcing
    D(3,3) = 0;
    F = U*D*V';

    F = T2'*F*T1;
end
