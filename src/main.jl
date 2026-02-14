include("Security_Transformation/FileSecurity.jl")
include("Security_Transformation/Transformation.jl")

using .Struct_Carte
function main()
    path = "data/street-map/Berlin_0_256.map"
    matrice = Remplir_Matrice_Cons(path)
    
    carte = Constructeur_Matrice_Cons(matrice)

    println(carte)
end
main()
