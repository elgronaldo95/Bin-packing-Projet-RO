

using JuMP, GLPK # On va utiliser JuMP et GLPK

# Structures contenant les données d'un problème de bin-packing mono-dimensionnel
struct objet1D
	taille::Int64 # Taille de l'objet
	nb::Int64 # Nombre d'objets de la même taille
end

struct donnees1D
	T::Int64 # Taille d'un bin
    nb::Int64 # Nombre de tailles d'objet différents
	tab::Vector{objet1D} # Tableau des objets à insérer dans les bins
end

# Structure représentant un bin
struct bin1D
    taille::Int64
    taille_disponible::Int64
    tab::Vector{objet1D}
end


# Converti un objet 1D en un tuple (taille, nb)
function objet1D_en_tuple(obj::objet1D)
    return obj.taille,obj.nb; 
end

# Converti une liste d'objet en une liste de tuple
function liste_objet_en_tuple(listeObjet::Vector{objet1D})

    nouvelleListe::Vector{Tuple{Int64,Int64}}

    for obj in listeObjet
        nouveauTuple::Tuple{Int64,Int64} = objet1D_en_tuple(obj)
        append!(nouvelleListe,nouveauTuple)
    end

    return nouvelleListe
end

function trie_objet1D(listeObjet::Vector{objet1D})

    listeTuple::Vector{Tuple{Int64,Int64}} = liste_objet_en_tuple(listeObjet)

    sort!(listeTuple,by = x -> x[1]);

    return listeTuple
end

function heuristique_fit1D(listeObjet::Vector{objet1D})

    listeTuple::Vector{Tuple{Int64,Int64}} = trie_objet1D(listeObjet)

    listBin::Vector{bin1D} 

	# TODO
    for t in listeTuple
        for b in listBin

        end
    end

end