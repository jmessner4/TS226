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
resultat=res==test;