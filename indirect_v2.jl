using JuMP, GLPK

function motifs_calc(type_courant::Int, somme::Int, taille_bin::Int, motif_local::Vector{Int}, types::Vector{Int}, motifs::Vector{Vector{Int}})
    ajout::Bool = false

    for type in type_courant:size(types,1)
        
        nouveau_somme = somme + types[type]

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


function tout_motifs(taille_bin::Int64, types::Vector{Int64})

    motif_local::Vector{Int} = []
    motifs::Vector{Vector{Int}} = [[]]

    return motifs_calc(1, 0, taille_bin, motif_local, types, motifs)

end

test = tout_motifs(10, [5,4,2])
