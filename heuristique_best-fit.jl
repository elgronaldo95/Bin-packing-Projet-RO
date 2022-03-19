
# Structure représentant un bin
mutable struct bin1D
    taille::Int64
    taille_disponible::Int64
    tab::Vector{objet1D}
end


# Converti un objet 1D en un tuple (taille, nb)
function objet1D_en_tuple(obj::objet1D)
    return obj.taille,obj.nb
end

# Converti une liste d'objet en une liste de tuple
function liste_objet_en_tuple(listeObjet::Vector{objet1D})

    taille::Int64 = length(listeObjet)

    nouvelleListe = Vector{Tuple{Int64,Int64}}()

    for obj in listeObjet
        nouveauTuple = objet1D_en_tuple(obj)
        append!(nouvelleListe,[nouveauTuple])
    end

    return nouvelleListe
end

# Trie une liste d'objet par ordre croissant de leur taille
function trie_objet1D(listeObjet::Vector{objet1D})

    resListeObjet = Vector{objet1D}()
    listeTuple = liste_objet_en_tuple(listeObjet)

    sort!(listeTuple,by = x -> x[1]);

    for t in listeTuple
        newObj = objet1D(t[1], t[2])
        append!(resListeObjet, [newObj])
    end
    return resListeObjet
end

function heuristique_fit1D(d1D::donnees1D)
    listeObjet::Vector{objet1D} = trie_objet1D(d1D.tab)

    # listeObjetTrie::Vector{objet1D} = trie_objet1D(listeObjet)

    tailleBin::Int64 = d1D.T

    newBin::bin1D(tailleBin, tailleBin, [])

    listeBin::Vector{bin1D} = [newBin]

    binPlusRempli = listeBin[1]

	# TODO
    # for obj in listeObjet
    #     if binPlusRempli.taille_disponible >= obj.taille
    # end

end

#= ************************* DEBUG ************************* =#
l_obj = [objet1D(5,3), objet1D(2,1), objet1D(3,3), objet1D(1,1)]

l_obj_trie = trie_objet1D(l_obj)
