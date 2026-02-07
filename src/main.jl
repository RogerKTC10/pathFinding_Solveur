include("Carte_Operation/Charger_Carte.jl")

function main()
    path = joinpath(@__DIR__, "..", "data", "street-map", "Berlin_0_256.map")
    elts = charger_valider(path)
    println("Chargement OK !", elts)
end

main()
