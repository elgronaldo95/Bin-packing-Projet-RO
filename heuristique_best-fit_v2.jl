# Dominik TANKO Gloire SAMBA 684I
# Modele heuristique best-fit

function heuristique_best_fit(d::donnees1D)

    # D'abord on trie le tableau des objets
    # rev = true : faut trier à l'inverse
    # alg = QuickSort : d'après les tests, QuickSort est le plus efficace
    sort!(d.tab, by = x -> x.taille, rev = true, alg = QuickSort)

    # Liste de la taille disponible dans chaque bin
    l_taille_dispo = [d.T]

    # Vrai si l'objet à été rangé dans un bin
    estObjetRange = false

    for i in d.tab

        # Objets restant de la même taille
        objets_restants = i.nb
        while objets_restants > 0
            estObjetRange = false

            # Indice de l_taille_dispo
            j = 1
            while (!estObjetRange && (j <= size(l_taille_dispo, 1)))
                if (l_taille_dispo[j] >= i.taille)
                    l_taille_dispo[j] -= i.taille
                    estObjetRange = true
                else
                    j += 1
                end
            end
            if !estObjetRange
                push!(l_taille_dispo, (d.T - i.taille))
            end
            objets_restants -= 1
        end
    end
    return size(l_taille_dispo, 1)
end