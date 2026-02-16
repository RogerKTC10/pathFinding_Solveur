include("Security_Transformation/FileSecurity.jl")
include("Security_Transformation/Transformation.jl")
include("My_Algorithms/Utils_Algorithms.jl")
include("My_Algorithms/BFS_Doc/BFS.jl")
include("affichage.jl")



using .Struct_Carte
function main()
    path = "data/street-map/Paris_0_1024.map"
    matrice = Remplir_Matrice_Cons(path)
    
    carte = Struct_Carte.Constructeur_Matrice_Cons(matrice)
    depart = (121, 180)
    arriver = (1020, 1024)
    res = execution_BFS(carte, depart, arriver)
    println(res)
    
    affichage_BFS(carte, res.chemin, res.distance, res.activite)
    readline()

end
main()
