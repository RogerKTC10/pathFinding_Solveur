include("Adaptation/Structure_Part2.jl") 
include("../Security_Transformation/Transformation.jl")
include("../My_Algorithms/Utils_Algorithms.jl")

using .Structure_Part2 
using .Struct_Carte

function voisinage_adaptation(triplet::tripletAMR, carte::Carte_Final_Value_Struct, G)

    x_act = triplet.x
    y_act = triplet.y
    t_act = triplet.t
    t_suiv = t_act + 1

    candidats = [tripletAMR(x_act - 1, y_act, t_suiv),
                 tripletAMR(x_act + 1, y_act, t_suiv), 
                 tripletAMR(x_act, y_act + 1, t_suiv), 
                 tripletAMR(x_act, y_act - 1, t_suiv), 
                 tripletAMR(x_act, y_act, t_suiv)]
    voisins_valides = tripletAMR[]
    
    for c in candidats
        
        if c.x >= 1 && c.x <= carte.height_val && 
           c.y >= 1 && c.y <= carte.width_val
            
            if BFS_Action_dict(c.x, c.y, G) 
                push!(voisins_valides, c)
            end
        end
    end

    return voisins_valides
end

function heuristique_adapter(triplet::tripletAMR)
    return triplet.t
end
function g_adapter(triplet::tripletAMR, arrivee::Tuple{Int, Int})
    return abs(triplet.x - arrivee[1]) + abs(triplet.y - arrivee[2])
end

function heuristique_Etoile_adaptation(triplet::Structure_Part2.tripletAMR, arrivee::Tuple{Int, Int})
    func_adapter = heuristique_adapter(triplet) + g_adapter(triplet, arrivee)

    return func_adapter
end

function reconstruire_chemin_adaptation(parents, depart_triplet, arrivee_triplet)
    chemin = []
    actuel = arrivee_triplet 
    
    while actuel != depart_triplet
        push!(chemin, actuel)

        if !haskey(parents, actuel)
            error("Le chemin est en perte ou inexistant")
        end

        actuel = parents[actuel]
    end
    
    push!(chemin, depart_triplet)
    chemin_inverse =  reverse(chemin)
    return chemin_inverse
end