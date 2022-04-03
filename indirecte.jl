using JuMP, GLPK

function modelisation_indirect(d::donnees1D)
    m = Model(GLPK.Optimizer)

    sort!(d.tab, by = x -> x.taille, rev = true, alg = QuickSort)

    tab_objet = tab_objet_taille_reelle(d)
    motifs = tout_motifs(d.T, tab_objet)

    nb_motifs = size(motifs, 1)

    @variable(m, x[1:nb_motifs], integer = true)

    @variable(m, a[1:d.nb, 1:nb_motifs], integer = true)

    @objective(m, Min, sum(x[j] for j in 1:nb_motifs))

    @constraint(m, objet_place[i=1:d.nb], sum(x[j]a[i,j] for j in 1:nb_motifs) >= d.tab[i].nb)

    return m

end


function scriptMonoIndirectJouetA()
	d::donnees1D = parser_data1D("Instances/1Dim/A/jouet.dat")
	
    @time m = modelisation_indirect(d)

    @time optimize!(m)

    status = termination_status(m)

    if status == MOI.OPTIMAL
        println("Problème résolu à l'optimalité")

        println("z = ", objective_value(m))

    elseif status == MOI.INFEASIBLE
        println("Problème non-borné")

    elseif status == MOI.INFEASIBLE_OR_UNBOUNDED
        println("Problème impossible")
    end

end