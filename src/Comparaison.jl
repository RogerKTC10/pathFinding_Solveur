include("My_Algorithms/BFS_Doc/BFS.jl")
include("My_Algorithms/Utils_Algorithms.jl")

#Mes prpre doutes d'Action
#Ca m'a permis de tester donc BFS et Djistkra sur des point de depart et d'arriver douteuse
function trouver_points_auto(matriceChar)
    h, w = size(matriceChar)
    
    # On définit des marges proportionnelles (5% de la carte)
    marge_h = max(1, floor(Int, h * 0.05))
    marge_w = max(1, floor(Int, w * 0.05))
    dist_test = max(2, floor(Int, w * 0.02)) # Petite distance pour Berlin, grande pour Paris

    # ÉTAPE 1 : On cherche un piège (Eau ou Marais)
    for type_obstacle in ['W', 'S']
        for i in (marge_h + 1):(h - marge_h)
            for j in (dist_test + 1):(w - dist_test)
                if matriceChar[i, j] == type_obstacle
                    # On vérifie si on a du sol de chaque côté
                    if matriceChar[i, j - dist_test] == '.' && matriceChar[i, j + dist_test] == '.'
                        println("🎯 Piège détecté type : $type_obstacle")
                        return (i, j - dist_test), (i, j + dist_test)
                    end
                end
            end
        end
    end

    # ÉTAPE 2 : Si aucun piège n'est trouvé, on prend juste deux points valides
    println("⚠️ Aucun obstacle spécifique trouvé, recherche de points standards...")
    points_valides = []
    for i in 1:h, j in 1:w
        if matriceChar[i, j] == '.'
            push!(points_valides, (i, j))
            if length(points_valides) > 100 break end # On en récupère quelques-uns
        end
    end

    if length(points_valides) >= 2
        return points_valides[1], points_valides[end]
    else
        error("La carte semble être remplie de murs !")
    end
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