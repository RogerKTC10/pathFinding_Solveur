include("Security_Transformation/FileSecurity.jl")
include("Security_Transformation/Transformation.jl")
include("My_Algorithms/Utils_Algorithms.jl")
include("My_Algorithms/BFS_Doc/BFS.jl")

using .Struct_Carte

function main()
    path = "data/street-map/Berlin_0_256.map"
    matrice = Remplir_Matrice_Cons(path)
    carte = Constructeur_Matrice_Cons(matrice)
    
    # CONSEIL : Sur Berlin, (1,1) est souvent un mur. 
    # Essaie (10, 10) pour être sûr que ça ne bloque pas direct.
    depart = (10, 10) 
    arriver = (40, 40) 
    
    # On stocke le résultat dans 'res'
    res = execution_BFS(carte, depart, arriver)

    # Vérification avant d'afficher (évite de crash si pas de chemin)
    if res.distance == -1
        println("❌ Aucun chemin trouvé.")
        return
    end

    # AFFICHAGE : Pour éviter que ça sature, on n'affiche que la zone utile
    # (Par exemple les 50 premières lignes/colonnes)
    for i in 1:min(50, carte.height)
        for j in 1:min(50, carte.width)
            if (i, j) == depart
                print("🟩") 
            elseif (i, j) == arriver
                print("🟥") 
            elseif (i, j) in res.chemin  # <--- CORRECTION ICI (res au lieu de lancer_BFS)
                print("🔵") 
            else
                msg, autorise = BFS_dic_Action(carte.grille[i,j])
                print(autorise ? "▫️ " : "⬛") 
            end
        end
        println() 
    end
    
    println("\n✅ Distance calculée : ", res.distance)
end

main()