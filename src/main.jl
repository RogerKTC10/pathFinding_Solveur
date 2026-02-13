include("Carte_Operation/Chargement.jl")
include("Carte_Operation/Transformation.jl")

using .Struct_Carte
function main()
    path = "data/street-map/Berlin_0_256.map"
    matrice = Remplir_Matrice_Cons(path)
    
    carte = Constructeur_Matrice_Cons(matrice)

    println(carte)
    println("Carte: $(carte.height)","$(carte.width)")
end
main()
