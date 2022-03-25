using JuMP, GLPK

function tabObjetTailleReelle(d::donnees1D)
    tabTailleReelle::Vector{Int64} = []

    for i in d.tab
        objets_restants::Int64 = i.nb
        while objets_restants > 0
            push!(tabTailleReelle, i.taille)
            objets_restants -= 1
        end
    end

    return tabTailleReelle;
end

function modelisation_direct(d::donnees1D)

        m = Model(GLPK.Optimizer)

        nombre_bin =  heuristique_best_fit(d)
        # nombre_objet = compte_objet(d)

        tab_objet = tabObjetTailleReelle(d)
        nombre_objet = size(tab_objet, 1)

        # Déclaration des variables
        @variable(m,x[1:nombre_objet,1:nombre_bin], binary = true)

        @variable(m,y[1:nombre_bin], binary = true)

        # Déclaration de la fonction objectif (avec le sens d'optimisation)
        @objective(m, Min, sum(y[j] for j in 1:nombre_bin ) )

        @constraint(m,bin_ouvert[i=1:nombre_objet], sum(x[i,j] for j in 1:nombre_bin) == 1 )

        @constraint(m,taille[j=1:nombre_bin], sum(tab_objet[i]*x[i,j] for i in 1:nombre_objet) <= d.T*y[j])

        return m
end


function scriptMonoJouetA()
	d::donnees1D = parser_data1D("Instances/1Dim/A/Jouet.dat")
	
    @time m = modelisation_direct(d)

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