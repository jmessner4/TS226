function u = viterbi_decode(res, y, treillis, s_i, closed)

m = treillis.numInputSymbols;
L = length(y)/log2(treillis.numOutputSymbols);
K = L - m;

Metrique = NaN(2^m, L+1);

j = 1;
c = zeros(1,2);
tmp=s_i+1;
for i=1:L+1
    dec = de2bi(treillis.outputs(tmp,res(j)+1),'left-msb');
    if length(dec)==1
        c(1)=0;
        c(2)=dec(1);
    else
        c(1)=dec(1);
        c(2)=dec(2);
    end
    
    calc = y(j)*c(1) + y(j+1)*c(2);
    tmp =treillis.nextStates(tmp,res(j)+1)+1;
    Metrique(tmp,i) = calc;
    j = j+2;
    
end


u = 4;