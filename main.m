clear,
close all,
clc,

treillis=poly2trellis(3,[5,7]);
u=[1,1,0,1,0];
s_i=0;
closed=false;
res=cc_encode(u,treillis,s_i,closed);

res2 = viterbi_decode(res, treillis, s_i, closed);