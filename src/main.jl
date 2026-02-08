include("Carte_Operation/Chargement.jl")
include("Carte_Operation/Transformation.jl")


function main()
    path = "data/street-map/Berlin_0_256.map"
    elts = charger_valider(path)
    if elts != nothing
        println("Chargement effectuer avec succes !\n")
    end
    matrice = Remplir_Matrice_Cons(path)

    if isnothing(matrice)
        println("Erreur de creation")
    else
        println(size(matrice))
        println(matrice)
    end
end
main()
