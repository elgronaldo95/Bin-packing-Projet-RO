

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

function trie_objet1D(l_obj1D::Vector{objet1D})
    

end