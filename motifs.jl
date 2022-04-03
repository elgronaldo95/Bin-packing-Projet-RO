# Fonction appelée localment
# Retourne un tableau de tableau contenant chaque possibilité de motifs
function motifs_calc(indice_type::Int, somme::Int, taille_bin::Int, motif_local::Vector{Int}, types::Vector{Int}, motifs::Vector{Vector{Int}})
    ajout::Bool = false

    for type in indice_type:size(types,1)
        
        nouveau_somme = somme + types[type]

        # cette ligne à changer pour le 2D
        if (nouveau_somme <= taille_bin)
            ajout = true

            push!(motif_local, type)

            vcat(motifs, motifs_calc(type, nouveau_somme, taille_bin, deepcopy(motif_local), types, motifs))
 
            pop!(motif_local)
        end
    end

    if (!ajout)
        push!(motifs, motif_local)
    end

    return motifs
end


# Retourne un tableau de tableau contenant chaque possibilité de motifs
function tout_motifs(taille_bin::Int64, types::Vector{Int64})

    motif_local::Vector{Int} = []
    motifs::Vector{Vector{Int}} = [[]]

    tout_motifs = motifs_calc(1, 0, taille_bin, motif_local, types, motifs)

    popfirst!(tout_motifs) # enlève le premier élément vide

    return tout_motifs
end

test = tout_motifs(10, [5,4,3,2])
