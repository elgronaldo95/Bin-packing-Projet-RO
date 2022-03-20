
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

    taille = length(listeObjet)

    nouvelleListe = Vector{Tuple{Int64,Int64}}()

    for obj in listeObjet
        nouveauTuple = objet1D_en_tuple(obj)
        append!(nouvelleListe,[nouveauTuple])
    end

    return nouvelleListe
end

# Trie une liste d'objet par ordre decroissant de leur taille
function trie_objet1D(listeObjet::Vector{objet1D})
    resListeObjet = Vector{objet1D}()
    listeTuple = liste_objet_en_tuple(listeObjet)

    sort!(listeTuple, by = x -> x[1], rev=true);

    for t in listeTuple
        newObj = objet1D(t[1], t[2])
        append!(resListeObjet, [newObj])
    end
    return resListeObjet
end

# Retourne une liste d'objet où chaque objet est unique
function flatten_liste_objet1D(listeObjet::Vector{objet1D})
    resListeObjet = Vector{objet1D}()

    for obj in listeObjet
        for i in 1:obj.nb
            newObj = objet1D(obj.taille, 1)
            append!(resListeObjet, [newObj])
        end
    end
    return resListeObjet
end

function heuristique_fit1D(d1D::donnees1D)

    listeObjet = flatten_liste_objet1D(trie_objet1D(d1D.tab))

    tailleBin = d1D.T

    newBin = bin1D(tailleBin, tailleBin, [])
    listeBin = [newBin]

    for obj in listeObjet
        for i in 1:length(listeBin)
            if listeBin[i].taille_disponible < obj.taille
                if length(listeBin) > i
                    i = i+1
                else
                    newBin = bin1D(tailleBin, (tailleBin-obj.taille), [])
                    append!(newBin.tab, [obj])
                    append!(listeBin, [newBin])
                    break
                end
            else
                append!(listeBin[i].tab, [obj])
                listeBin[i].taille_disponible = (listeBin[i].taille_disponible - obj.taille)
                break
            end
        end
    end

    return listeBin
end

#= ************************* DEBUG AND TESTS ************************* =#
l_obj = [objet1D(5,3), objet1D(2,1), objet1D(3,3), objet1D(1,1)]

l_obj_trie = trie_objet1D(l_obj)

l_obj_flat = flatten_liste_objet1D(l_obj_trie)

l_obj_final = flatten_liste_objet1D(trie_objet1D([objet1D(5,3), objet1D(2,1), objet1D(3,3), objet1D(1,1)]))

d1 = donnees1D(10, 4, [objet1D(5,3), objet1D(2,1), objet1D(3,3), objet1D(1,1)])

myListeBin = heuristique_fit1D(d1)



#=
if b.taille_disponible >= obj.taille
    append!(b.tab, [obj])
    b.taille_disponible = (b.taille_disponible - obj.taille)
    break
else
    newBin = bin1D(tailleBin, tailleBin, [])
    append!(newBin.tab, [obj])
    newBin.taille_disponible = (newBin.taille_disponible - obj.taille)
    append!(listeBin, [newBin])
end
            =#