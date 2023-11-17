function [R, t] = relative_orientation_23(m2, m1, K2, K1)
    n = size(m1, 2);
    m1 = [m1; ones(1, n)];
    m2 = [m2; ones(1, n)];
    
    m1 = inv(K1)*m1; %NIC normalized image coordinates
    m2 = inv(K2)*m2; %come sopra

    E = ottopunti(m2(1:2,:), m1(1:2,:));  %questo perchè ottopunti non lavora con i punti omogenei
    S1 = skew([0 0 -1]); %matrice antisimmetrica di partenza
    R1 = eul([0 0 pi/2]); %matrice di rotazione di partenza  

    [U, D, V] = svd(E);

    %ora facciamo i quattro casi
    %ci dobbiamo mettere S1, oppure -S1, ed R1 oppure R1'
    
    for k = 1:4
        S = (-1)^k*U*S1*U'; %alterno i segni di S1
        if k==3
           R1 = R1'; %scambio la R1 con la sua trasposta per fare tutte le combinazioni con S1 e -S1
        end
        t = [S(3,2);S(1,3);S(2,1)];
        t = t./norm(t);
        R = det(U*V')*U*R1*V';
        
        %credo sia a la soluzione di un sistema lineare con Kramer
        z = [m2(:,1), -R*m1(:,1)]\t;
        if z(1)>0 && z(2)>0
            break;
        end
    end
end
