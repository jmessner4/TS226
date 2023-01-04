function [c,s_f] = cc_encode(u,treillis,s_i,closed)

cpt=1;
c=zeros(1,2*length(u));
while(closed==false)
    tmp=s_i+1;
    for i=1:2:2*length(u)
        dec=de2bi(treillis.outputs(tmp,u(cpt)+1),'left-msb');
        if length(dec)==1
            c(i)=0;
            c(i+1)=dec(1);
        else
            c(i)=dec(1);
            c(i+1)=dec(2);
        end
        tmp=treillis.nextStates(tmp,u(cpt)+1)+1;
        cpt=cpt+1;
        if (cpt==length(u))
            closed=true;
        end
    end
end
s_f=treillis.outputs(tmp,u(length(u))+1);