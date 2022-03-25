################# METHODE HEURISTIQUE BEST-FIT ####################

function modele_heuristique_best_fit(d::donnees1D)

    sort!(d.tab, by = x -> x.taille, rev = true)

    #Liste de la taille disponible dans chaque contenaires
    liste_bin::Vector{Int64} = [d.T]

    #Vaut true si l'objet à été rangé dans un bin
    objectStored::Bool = false

    for i in d.tab

        #nombre restant d'objets de la même taille
        nbLeft::Int64 = i.nb
        while nbLeft > 0
            objectStored = false

            #Indice de liste_bin
            j::Int64 = 1
            while (!objectStored && (j <= size(liste_bin, 1)))
                if (liste_bin[j] >= i.taille)
                    liste_bin[j] -= i.taille
                    objectStored = true
                else
                    j += 1
                end
            end
            if !objectStored
                push!(liste_bin, (d.T - i.taille))
            end
            nbLeft -= 1
        end
    end
    return size(liste_bin, 1)
end