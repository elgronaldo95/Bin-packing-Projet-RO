using JuMP, GLPK

using Printf

function compte_objet(d::donnees1D)

    nobj::Int64 = 0

    for i in d.nb

        nobj += d.tab[i].nb

    end

    return nobj

end

function modelisation_direct(d::donnees1D)

        m= Model(GLPK.Optimizer)

        nombre_bin::Int64 =  heuristique_best_fit(d)


        nombre_objet::int64 = compte_objet(d)

        # Déclaration des variables
        @variable(m,x[1:nombre_objet,1:nombre_bin], binary = true)

        @variable(m,y[1:nombre_bin], binary = true)

        # Déclaration de la fonction objectif (avec le sens d'optimisation)
        @objective(m, Min, sum(y[j] for j in 1:nombre_bin ) )

        @constraint(m,bin_ouvert[i=1:nombre_objet], sum(x[i,j] for j in 1:nombre_bin) == 1 )

        @constraint(m,taille[i= 1:nombre_objet],sum(d.tab[i].taille*x[i,j] for i in 1:nombre_bin) <= d.T*y[j])

        return m
end