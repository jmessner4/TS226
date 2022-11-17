function u = = viterbi_decode(y, trellis, s_i, closed)

m = trellis.numInputSymbols;
L = length(y)/log2(trellis.numOutputSymboles);
K = L - m;