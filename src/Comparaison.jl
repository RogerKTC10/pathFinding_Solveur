include("My_Algorithms/BFS_Doc/BFS.jl")
include("My_Algorithms/Utils_Algorithms.jl")

#Mes prpre doutes d'Action
#Ca m'a permis de tester donc BFS et Djistkra sur des point de depart et d'arriver douteuse
function trouver_points_pieges(matriceChar)
    h, w = size(matriceChar)
    for i in 100:h-100
        for j in 100:w-100
            if matriceChar[i, j] == 'W'
                if matriceChar[i, j-20] == '.' && matriceChar[i, j+20] == '.'
                    println("🎯 Piège trouvé !")
                    println("Départ (sol) : ", (i, j-20))
                    println("Eau au milieu : ", (i, j))
                    println("Arrivée (sol) : ", (i, j+20))
                    return (i, j-20), (i, j+20)
                end
            end
        end
    end
    error("Aucun piège trouvé sur cette carte. Change de zone ou de carte !")
end

function detecter_zones_interet(matriceChar)
    h, w = size(matriceChar)
    
    # On scanne la carte à la recherche d'eau 'W' (priorité ville)
    for i in 20:h-20
        for j in 20:w-20
            if matriceChar[i, j] == 'W'
                
                # On a trouvé de l'eau ! Maintenant on cherche la rive GAUCHE
                dep_j = j
                while dep_j > 1 && matriceChar[i, dep_j] != '.'
                    dep_j -= 1
                end
                
                # Et on cherche la rive DROITE
                arr_j = j
                while arr_j < w && matriceChar[i, arr_j] != '.'
                    arr_j += 1
                end

                # Si on a trouvé du sol des deux côtés sans sortir de la carte
                if matriceChar[i, dep_j] == '.' && matriceChar[i, arr_j] == '.'
                    # On s'écarte encore de 2 pixels pour être bien sur la route
                    final_dep = (i, max(1, dep_j - 2))
                    final_arr = (i, min(w, arr_j + 2))
                    
                    println("✅ Rives trouvées à Berlin ! Départ: $final_dep, Arrivée: $final_arr")
                    return final_dep, final_arr
                end
            end
        end
    end
    
    # Si pas d'eau, on fait la même chose avec le marais 'S'
    # (Même code mais avec 'S', je te passe la répétition pour rester simple)
    error("Aucune zone d'eau avec des rives accessibles n'a été trouvée sur cette ville.")
end



#---Spécifiquement pour le BFS------
function calculer_cout_chemin(chemin, matriceChar)
    total_facture = 0.0

    # On parcourt le chemin à partir de la deuxième case
    for k in 2:length(chemin)
        i, j = chemin[k]
        caractere = matriceChar[i, j]
        prix_passage = valuation(caractere)
        
        total_facture += prix_passage
    end

    return total_facture
end

function CPUtime()
end

function Number_State_Value()
end