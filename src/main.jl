include("Security_Transformation/FileSecurity.jl")
include("Security_Transformation/Transformation.jl")
include("My_Algorithms/Utils_Algorithms.jl")
include("My_Algorithms/BFS_Doc/BFS.jl")


using .Struct_Carte
function main()
    path = "data/street-map/Berlin_0_256.map"
    matrice = Remplir_Matrice_Cons(path)
    
    carte = Constructeur_Matrice_Cons(matrice)
    depart = (1, 1)
    arriver = (250, 250)
    lancer_BFS = execution_BFS(carte, depart, arriver)
    #println(lancer_BFS)

   if res.distance == -1
        println("❌ Aucun chemin trouvé. Vérifiez que le départ/arrivée ne sont pas des murs.")
        return # On arrête ici si rien n'est trouvé
    end

    println("✅ Chemin trouvé ! Distance : ", res.distance)
    
    # AFFICHAGE DU SCHÉMA (Seulement sur une zone limitée pour que ce soit beau)
    # Ici on définit les bornes pour ne pas tout afficher d'un coup
    margin = 5
    min_i = max(1, min(depart[1], arriver[1]) - margin)
    max_i = min(carte.height, max(depart[1], arriver[1]) + margin)
    min_j = max(1, min(depart[2], arriver[2]) - margin)
    max_j = min(carte.width, max(depart[2], arriver[2]) + margin)

    println("\n--- Aperçu de la zone du chemin ---")
    for i in min_i:max_i
        for j in min_j:max_j
            if (i, j) == depart
                print("🟩")
            elseif (i, j) == arriver
                print("🟥")
            elseif (i, j) in res.chemin
                print("🔵")
            else
                char = carte.grille[i, j]
                print(char == '@' || char == 'T' ? "⬛" : "▫️ ")
            end
        end
        println()
    end
end
main()
