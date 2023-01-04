clear,
close all,
clc,

treillis=poly2trellis(3,[5,7]);
u=randi([0 1],1,8);
utest = [1 1 0 1 0];
s_i=0;
closed=false;

[res,s_f]=cc_encode(u,treillis,s_i,closed);
%On utiliser convenc pour vérifier que l'on obtient le bon résultat

y = zeros(1, length(res));

for i=1:length(res)
    if(res(i) == 1)
        y(i) = -1;
    else
        y(i) = 1;
    end
end

res = viterbi_decode(y, treillis, s_i, closed);


% %Impact sur la mémoire du code
% 
% test1=poly2trellis(2,[2,3]);
% test2=poly2trellis(3,[5,7]);
% test3=poly2trellis(4,[13,15]);
% test4=poly2trellis(7,[133,171]);
% 
% calculTEB(test1);
% calculTEB(test2);
% calculTEB(test3);
% calculTEB(test4);
% 
% figure,
% plot(test1),
% hold on,
% plot(test2),
% plot(test3),
% plot(test3),

% y2 = [-1 -1 -1 -1 1 1 -1 1 1 1 -1 1 -1 -1];
% 
% res2 = viterbi_decode(y, treillis, s_i, closed);
