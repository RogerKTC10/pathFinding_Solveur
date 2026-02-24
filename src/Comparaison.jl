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
    
    # On fixe des valeurs simples qui marchent partout
    saut = 15  # Distance entre le départ et l'eau
    marge = 20 # Pour ne pas taper les bords de la carte

    # On cherche d'abord l'eau 'W', sinon le marais 'S'
    for cible in ['W', 'S']
        for i in (marge + 1):(h - marge)
            for j in (saut + 1):(w - saut)
                
                # 1. Est-ce qu'on a trouvé l'obstacle ?
                if matriceChar[i, j] == cible
                    
                    # 2. Est-ce que le départ et l'arrivée sont du sol '.' ?
                    if matriceChar[i, j - saut] == '.' && matriceChar[i, j + saut] == '.'
                        
                        println("📍 Zone trouvée ! Type: $cible")
                        return (i, j - saut), (i, j + saut)
                    end
                end
            end
        end
    end
    
    # Si vraiment aucune eau/marais n'est traversable, on prend deux points de sol au hasard
    println("⚠️ Aucun obstacle trouvé, recherche de sol standard...")
    return (marge+1, marge+1), (h-marge, w-marge)
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