P1 = rand(3, 4)
M = rand(3, 10);

m = proj(P1, M);

P2 = resect(m, M)  %se tutto è corretto, le due P sono uguali (a meno di un fattore di scala)

%verifica

%metodo difficile
rank([P1(:), P2(:)]) %vettorizzo le p, le metto in una mat e calcolo il rango, Se sono collineari, il rango è 1 (ovvero sono uguali a meno di un fattore di scala, ovvero sono lin. dip.)
%Vediamo anche con svd svd([P1(:), P2(:)]). E guardiamo
%l'ultimo sigma. più piccolo è quello, più sono collineari.

svd([P1(:), P2(:)])

%metodo facile

P1 ./ P2 % se mi dà tutto lo stesso valore è corretto.