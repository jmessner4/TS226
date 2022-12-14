function u = viterbi_decode(res, y, treillis, s_i, closed)

m = treillis.numInputSymbols;
L = length(y)/log2(treillis.numOutputSymbols);
K = L - m;

Metrique = NaN(2^m, L+1);   %Tableau pour conserver la métrique
Metrique(1,1) = 0;
Distance = NaN(4, L); %Tableau pour conserver le meilleur chemin
Distance(1,1) = 0;
Distance(2,1) = Inf;
Distance(3,1) = Inf;
Distance(4,1) = Inf;
j = 1;
c = zeros(1,2);
tmp=s_i+1;
for i=1:2:L
     Metrique(1,i) = norm([-1,-1]-[y(i), y(i+1)]);       %Transition 00 vers 00
     Metrique(2,i) = norm([1,1]-[y(i), y(i+1)]);         %Transition 00 vers 10
     Metrique(3,i) = norm([-1,1]-[y(i), y(i+1)]);        %Transition 10 vers 01
     Metrique(4,i) = norm([1,-1]-[y(i), y(i+1)]);        %Transition 10 vers 11
     Metrique(5,i) = norm([1,1]-[y(i), y(i+1)]);         %Transition 01 vers 00
     Metrique(6,i) = norm([-1,-1]-[y(i), y(i+1)]);       %Transition 01 vers 10
     Metrique(7,i) = norm([1,-1]-[y(i), y(i+1)]);        %Transition 11 vers 01
     Metrique(8,i) = norm([-1,1]-[y(i), y(i+1)]);        %Transititon 11 vers 11
end
for i=1:L
    
    Distance(1,i+1) = min(Distance(1,i)+Metrique(1,i),Distance(3,i)+Metrique(5,i));     %Distance min pour atteindre 00 au tour i
    Distance(2,i+1) = min(Distance(1,i)+Metrique(2,i), Distance(3,i)+Metrique(6,i));    %Distance min pour atteindre 10 au tour i
    Distance(3,i+1) = min(Distance(2,i)+Metrique(3,i), Distance(4,i)+Metrique(7,i));    %Distance min pour atteindre 01 au tour i
    Distance(4,i+1) = min(Distance(2,i)+Metrique(4,i), Distance(4,i)+Metrique(8,i));    %Distance min pour atteindre 11 au tour i
    
end


u = 4;