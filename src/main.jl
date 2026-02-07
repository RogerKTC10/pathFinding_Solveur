include("Carte_Operation/Chargement.jl")

function main()
    path = "data/street-map/Berlin_0_256.map\n"
    elts = charger_valider(path)
    println("Chargement effectuer avec succes !\n", elts)
end
main()
