elaboration;

[K, R, t] = krt(P);
C = -R' * t


%oppure anche
Ptil = P(:, 1:3);
p4   = P(:, 4);

C = - inv(Ptil) * p4