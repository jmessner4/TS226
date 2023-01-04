function u = viterbi_decode(y, treillis, s_i, closed)

ns = treillis.numOutputSymbols/treillis.numInputSymbols;
numStates = treillis.numStates;
m = log2(numStates);
L = length(y)/log2(treillis.numOutputSymbols);
K = L - m;

outputs = treillis.outputs;

EtatsParcourus = NaN(2^m, L+1);
EtatsParcourus(s_i+1, 1) = s_i;

Metrique = NaN(2^m, L+1);   %Tableau pour conserver la métrique
Metrique(:,1) = 0;
Distance = NaN(2^m, L); %Tableau pour conserver le meilleur chemin

for tour=1:L
    for etat=1:numStates
        for i=1:2
            sortie = outputs(etat, i);   %sortie du tour
            sortieb = de2bi(sortie,'left-msb');
            if length(sortie)==1
                sortiebin(1)=0;
                sortiebin(2)=sortieb(1);
            else
                sortiebin(1)=sortieb(1);
                sortiebin(2)=sortieb(2);
            end
            section = y((tour-1)*ns+1:tour*ns)';
            res1 = Metrique(etat,tour) + sortiebin*section;
            %Calcul de la métrique
            if( ((tour <= K)&&(closed)) || (~closed) )
                next_state = treillis.nextStates(etat,i);
                Metrique(next_state+1,tour+1) = min(Metrique(next_state+1,tour+1), res1);
                if (Metrique(next_state+1,tour+1) == res1)
                    EtatsParcourus(next_state+1,tour+1) = etat-1;
                    Distance(next_state+1, tour) = i-1;
                end
            % Procédure en cas de fermeture
            else
                next_state = treillis.nextStates(etat,i);
                % Etat ne permettant pas la fermeture du trellis
                if (next_state > close_branch-1)
                    if (etat == numStates && i == 2)
                        % Diminue la valeur du nombre d'état restant
                        close_branch = close_branch -1;
                    end
                    continue;
                end
                % calcul du poids
                Metrique(next_state+1,section+1) = min(Metrique(next_state+1,tour+1), res1);
                 % écrasement du tableau d'état
                if (Metrique(next_state+1,tour+1) == res)
                    EtatsParcourus(next_state+1,tour+1) = etat-1;
                    Distance(next_state+1, tour) = i-1;
                end
                if (etat == numStates && i == 2)
                    % Diminue la valeur du nombre d'état restant
                    close_branch = close_branch -1;
                end
            end
        end
    end     
end

%%Décodage

u = zeros(1,L);
[~,etat_possible] = min(Metrique(:,L+1));
etat_possible = etat_possible-1;

for cheminretour=L:-1:1
    u(cheminretour) = Distance(etat_possible+1, cheminretour);
    etat_possible = EtatsParcourus(etat_possible+1, cheminretour+1);
end


%u = (u(1:K)>0);

