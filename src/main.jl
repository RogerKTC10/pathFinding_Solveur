include("Security_Transformation/FileSecurity.jl")
include("Security_Transformation/Transformation.jl")
include("My_Algorithms/Utils_Algorithms.jl")
include("My_Algorithms/BFS_Doc/BFS.jl")
include("affichage.jl")



using .Struct_Carte
function main()
    path = "data/street-map/Berlin_0_256.map"
    matrice = Struct_Carte.Remplir_Matrice_Cons(path)
    
    carte = Struct_Carte.Constructeur_Matrice_Cons(matrice)
    depart = (1, 1)
    arriver = (250, 250)
    res = execution_BFS(carte, depart, arriver)
    
    affichage_BFS(carte, res.chemin)

end
main()
