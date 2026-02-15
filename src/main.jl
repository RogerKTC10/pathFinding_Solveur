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
    println(lancer_BFS)

    # On parcourt la grille ligne par ligne
        for i in 1:carte.height
            for j in 1:carte.width
                # 1. Priorité : Est-ce le départ ou l'arrivée ?
                if (i, j) == depart
                    print("🟩") # Départ (Carré vert)
                elseif (i, j) == arriver
                    print("🟥") # Arrivée (Carré rouge)
                
                # 2. Est-ce une case du chemin trouvé ?
                elseif (i, j) in lancer_BFS.chemin
                    print("🔵") # Le chemin (Points bleus)
                
                # 3. Sinon, on affiche le terrain selon ton dictionnaire
                else
                    char = carte.grille[i, j]
                    if char == '@' || char == 'T'
                        print("⬛") # Mur / Obstacle
                    else
                        print("▫️ ") # Espace vide / Herbe
                    end
                end
            end
            println() # Retour à la ligne pour la rangée suivante
        end
        println("\nLégende : 🟩 Départ | 🟥 Arrivée | 🔵 Chemin | ⬛ Mur")
end
main()
