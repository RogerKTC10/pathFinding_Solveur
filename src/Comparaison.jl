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
    
    # On définit la liste des obstacles par ordre de "spectacle" (Eau d'abord, puis Marais)
    # On ne prend que ce qui a une valuation > 1.0
    obstacles = ['W', 'S']

    for cible in obstacles
        for i in 20:h-20
            for j in 20:w-20
                # Si on trouve un pixel qui coûte cher
                if matriceChar[i, j] == cible
                    
                    # On cherche le sol libre ('.') à GAUCHE
                    dep_j = j
                    while dep_j > 2 && matriceChar[i, dep_j] != '.'
                        dep_j -= 1
                    end
                    
                    # On cherche le sol libre ('.') à DROITE
                    arr_j = j
                    while arr_j < w-2 && matriceChar[i, arr_j] != '.'
                        arr_j += 1
                    end

                    # Si on a bien trouvé du sol des deux côtés
                    if matriceChar[i, dep_j] == '.' && matriceChar[i, arr_j] == '.'
                        # On s'éloigne un peu pour être sûr de ne pas être collé à l'obstacle
                        final_dep = (i, max(1, dep_j - 1))
                        final_arr = (i, min(w, arr_j + 1))
                        println("🎯 Zone détectée ! Type: $cible | Départ: $final_dep | Arrivée: $final_arr")
                        return final_dep, final_arr
                    end
                end
            end
        end
    end
    
    # Si après avoir tout cherché on n'a rien trouvé, on prend deux points de route au hasard
    println("⚠️ Aucun obstacle spécial. Dijkstra et BFS donneront sûrement le même coût.")
    return (50, 50), (h-50, w-50)
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