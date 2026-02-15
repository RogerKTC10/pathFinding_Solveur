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
    res = execution_BFS(carte, depart, arriver)
    #println(lancer_BFS)

    if res.distance == -1
        for i in 1:carte.height
          for j in 1:carte.width
            if (i, j) == depart
                print("🟩") # Départ
            elseif (i, j) == arriver
                print("🟥") # Arrivée
            elseif (i, j) in lancer_BFS.chemin
                print("🔵") # Le chemin tracé par ton BFS
            else
                # On utilise ta logique d'obstacle pour l'affichage
                msg, autorise = BFS_dic_Action(carte.grille[i,j])
                print(autorise ? "▫️ " : "⬛") # Noir si obstacle, point si libre
            end
        end
        println() # Saut de ligne
    end
end
end
main()
