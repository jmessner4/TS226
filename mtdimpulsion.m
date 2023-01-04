function TEP = mtdimpulsion(d0,d1,K,N, treillis,s_i,closed,R, EbN0)

v = zeros(1,K);
x = zeros(1,K);
y = ones(1,N);

for l=1:K
    A = d0-0.5;
    xc = x;
    while((xc==x) & (A<d1))
        A = A+1;
        y(l) = 1-A;
        xc = viterbi_decode(y,treillis,s_i,closed);
    end
    v(l) = floor(A);
end

D = min(v):max(v); %D est l'ensemble des entiers dans v donc l'esnemble des entiers compris entre l'élément min et l'élément max de v

Ad = zeros(1: length(D));
TEP = 0;

for d=1:length(D)
    Ad(d) = sum(v==d);
    TEP = TEP + 1/2*(Ad(d)*erfc(sqrt(d*R*EbN0)));
end