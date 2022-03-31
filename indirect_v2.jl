using JuMP, GLPK

struct arbre_type
    place_restant::Int64
    taille_objet::Int64
    fils::Vector{arbre_type}

end

function parcours_arbre()

end