function [T, m] = precond(m)
    avg = mean(m, 2);
    m = m - avg;
    scale = mean(sqrt(sum(m.^2,1)))/sqrt(size(m,1));
    m = m./scale;
    T = [eye(size(m,1)) -avg]./scale;
    T(end+1, end) = 1;
end
