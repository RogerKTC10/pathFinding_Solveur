include("../Utilitaire_Part2.jl")

using DataStructures
using .Structure_Part2  
using .Struct_Carte

function execution_Etoile_Adaptation(G, vdepart, varriver, G_dict, intervalles_dict, t_depart::Int)
    dep_y, dep_x = Int(vdepart[1]), Int(vdepart[2])
    arr_y, arr_x = Int(varriver[1]), Int(varriver[2])
    
    g_score = Dict{Structure_Part2.tripletAMR, Float64}() 
    
    # --- CORRECTION VITALE ---
    # On initialise le triplet avec le temps de départ fourni (t_depart)
    # et non plus 0. C'est ce qui permet d'enchaîner les 399 missions.
    depart_triplet = Structure_Part2.tripletAMR(dep_y, dep_x, t_depart) 
    # -------------------------

    g_score[depart_triplet] = 0.0
    parents = Dict{Structure_Part2.tripletAMR, Structure_Part2.tripletAMR}()
    nb_etat_evaluer = 0
    maFile = PriorityQueue{Structure_Part2.tripletAMR, Float64}()

    # L'heuristique doit aussi prendre en compte le point de départ temporel
    maFile[depart_triplet] = 0.0 + h_adapter(depart_triplet, (arr_y, arr_x))

    while !isempty(maFile)
        actuel = dequeue!(maFile)
        nb_etat_evaluer += 1

        # Condition d'arrêt : on est arrivé aux coordonnées cibles
        if actuel.y == arr_y && actuel.x == arr_x
            # On passe bien le depart_triplet correct pour la reconstruction
            chemin_suivi = reconstruire_chemin_adaptation(parents, depart_triplet, actuel)
            return (chemin = chemin_suivi, cout = g_score[actuel], activite = nb_etat_evaluer)
        end

        # Le voisinage SIPP va maintenant explorer le FUTUR à partir de actuel.t
        for voisin in voisinage_SIPP(actuel, G, G_dict, intervalles_dict)
            
            # Calcul du coût de l'action
            if voisin.x == actuel.x && voisin.y == actuel.y
                poids_action = 1.0 # Coût d'attente sur place
            else
                poids_action = recup_cout_chemin(voisin.y, voisin.x, G)
            end

            nouveau_g = g_score[actuel] + poids_action 

            # Mise à jour du chemin si on trouve mieux ou nouveau
            if !haskey(g_score, voisin) || nouveau_g < g_score[voisin]
                g_score[voisin] = nouveau_g 
                parents[voisin] = actuel
                priorite_f = nouveau_g + h_adapter(voisin, varriver)
                maFile[voisin] = priorite_f
            end
        end
    end 
    
    # Si la file est vide sans avoir trouvé l'arrivée
    return (chemin = [], cout = Inf, activite = nb_etat_evaluer)
end