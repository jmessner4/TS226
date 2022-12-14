function [TEB] = calculTEB (treillis)

EbN0dB_min  = 0; 
EbN0dB_max  = 10; 
EbN0dB_step = 0.5;

EbN0dB = EbN0dB_min:EbN0dB_step:EbN0dB_max;
EbN0 = 10.^(EbN0dB/10);
len=length(EbN0);
TEB=zeros(1,len);
ErrTotal=100;

for i=1:len
    NbErr=0;    %On compte le nombre d'erreur
    cpt=0;      %On compte le nombre envoyé
    while NbErr<ErrTotal
        cpt=cpt+1;
        %Il faut que l'on génére un mot aléatoire
        u=randi([0 1],1,1024);
        %On choisit 1024 car c'est le nombre de bits par message
        closed=false;
        [c,s_f]=cc_encode(u,treillis,closed);
        %On choisit l'état inital à 0 par convention
        s_i=0;
        dec=viterbi_decode(c,y,treillis,s_i,closed);
        DiffErr=sum(dec~=u);
        NbErr=NbErr+DiffErr;
    end
    NbBitEnv=cpt*1024;
    TEB(i)=NbErr/(NbBitEnv);
end