function avgval = calc_average(m1, m2, F)
    homom1 = [m1; ones(1, size(m1, 2))];
    homom2 = [m2; ones(1, size(m2, 2))];
   
    %non lo posso fare in forma matriciale, devo falro punto per punto
    tmp = [];
    for i = 1:size(m1,2)
        tmp = [tmp homom2(:,i)'*F*homom1(:,i)];
    end
    
    %i valori devono essere tutti piccoli
    avgval = mean(tmp);
