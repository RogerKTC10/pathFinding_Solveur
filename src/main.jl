include("Carte_Operation/Chargement.jl")
include("Carte_Operation/Transformation.jl")


function main()
    path = "data/street-map/Berlin_0_256.map"
    elts = charger_valider(path)
    println("Chargement effectuer avec succes !\n")
    matrice = Remplir_Matrice_Cons(path)
    println(size(matrice))
    println(matrice)
        
end
main()
