using JuMP, GLPK

include("heuristique_best-fit_v2.jl")
include("motifs.jl")

function modelisation_indirect(d::donnees1D)
    m = Model(GLPK.Optimizer)

    sort!(d.tab, by = x -> x.taille, rev = true, alg = QuickSort)

    nombre_bin =  heuristique_best_fit(d)
    motifs = tout_motifs(d.T, d.tab)

    nb_motifs = size(motifs, 1)

    @variable(m, x[1:nb_motifs], integer = true)