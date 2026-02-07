#ICI JE VOUDRAIS FAIRE UNE BOUCLE NON ITERATIVE A L'EXEMPLE D'UNE EX2CUTION SHELL
include("Carte_Operation/Charger_Carte.jl")

function main() 
    path = joinpath(@__DIR__, "..", "street-map", "Berlin_0_256.map") 
    elts = charger_valider(path) 
    println("Chargement OK !") 
end 
main()

