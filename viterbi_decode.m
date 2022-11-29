function u = viterbi_decode(y, trellis, s_i, closed)

m = trellis.numInputSymbols;
L = length(y)/log2(trellis.numOutputSymbols);
K = L - m;

Metrique = Nan(2^m, L+1);

for i=1:L+1
    trellis.NextStep(s_i) 
end


u = 4;