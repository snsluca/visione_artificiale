% m : punti 2d
% M : punti 3d
% K : parametri intrinseci della camera

function [R,t]  = fiore(m, M, K)
    n = size(M, 2);
    
    M = [M; ones(1, n)]; %ci appiccico una riga di 1 sotto ad M; questo mi trasforma M in coordinate omogenee
    m = [m; ones(1, n)]; %ci appiccico una riga di 1 sotto ad m; questo mi trasforma m in coordinate omogenee
    q = inv(K)*m; %applico la tf K ai punti 2d omogenei. Questi q sono già 1 in fondo, non serve fare la divisione prospettica (normalizzare q per imporre l'ultimo elemento ad 1)
    [~, D, V] = svd(M);
    r = rank(M); %questo è didattico, perchè matlab per calcolare rank fa l'svd. Potremmo evitare di fare rank qui, ed usare la formula che usa internamente matlab. Qui non lo facciamo per questioni didattiche.
    Vr = V(:, r+1:end); %fino ad r, i valori sono significativi; dopo r, sono quasi nulli e possono essere approssimati a 0.
    [~, ~, V] =  svd(kron(Vr', q)*faiD(n));
    %z qui è definito a meno di una scala, che può essere anche un segno. Se z è negativo, ci dà dei punti che sono dietro la camera. Ci basta prendere il primo z (tutti gli altri hanno lo stesso segno). In questo modo, forziamo il segno che vogliamo noi (positivo).

    z = V(:, end);
    z = z * sign(z(1));

    [s, R, t] = opa23(q*diag(z), M(1:3, :)); %gli passo i punti immagine scalati per la propria zeta e gli M in coordinate cartesiane.
