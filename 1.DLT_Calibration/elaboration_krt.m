run("elaboration.m");

[K, R, t] = krt(P);

%calcolo il centro per vedere se è corretto
C = -R' * t;

%oppure anche
%Ptil = P(:, 1:3);
%p4   = P(:, 4);
%
%C = - inv(Ptil) * p4
