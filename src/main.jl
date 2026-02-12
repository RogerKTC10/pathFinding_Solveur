include("Carte_Operation/Chargement.jl")
include("Carte_Operation/Transformation.jl")


function main()
    path = "data/street-map/Berlin_0_256.map"
    elts = charger_valider(path)
    println("Chargement effectuer avec succes !\n")
    matrice = Remplir_Matrice_Cons(path)
    println(size(matrice))
    println(matrice)
    println("=== MATRICE 256x256 COMPLET ===")
    for i in 1:256
        line = join(mat[i, :])  # Concatène sans espaces
        println(line)
    end
        
end
main()
