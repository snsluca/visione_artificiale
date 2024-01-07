function M = calctriangulation(P_arr, m_arr)
    % nsets = 2 if two-view, nsets = 3 for three-view, and so on.
    nsets   = size(m_arr, 2);

    % number of points for each point set (for example, npoints = 12)
    % all sets have the same number of points, so I take the length of the 
    %first one without any loss of generality.
    npoints = size(m_arr{1},2);

    for i = 1:npoints
        % generates tmp = {m1(:,i), m2(:,i)}
        tmp = {};
        for k = 1:nsets
            tmp{k} = m_arr{k}(:,i);
        end
        M(:,i) = classe_triangulation_23(P_arr, tmp);
    end

    % nonlinear refinement
    M = triang_nonlin_batch(M, P_arr, m_arr);
end
