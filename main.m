clear,
close all,
clc,

treillis=poly2trellis(3,[5,7]);
u=[1,1,0,1,0];
s_i=0;
test=convenc(u,treillis,s_i);
closed=false;
res=cc_encode(u,treillis,s_i,closed);

test=convenc(u,treillis,s_i);

y = zeros(1, length(res));

for i=1:length(res)
    if(res(i) == 1)
        y(i) = -1;
    else
        y(i) = 1;
    end
end

res = viterbi_decode(res, y, treillis, s_i, closed);