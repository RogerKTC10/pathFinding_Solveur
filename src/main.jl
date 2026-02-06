#ICI JE VOUDRAIS FAIRE UNE BOUCLE NON ITERATIVE A L'EXEMPLE D'UNE EX2CUTION SHELL

function main()
    path = "data/street-map/Berlin_O_256.map"   # ou un chemin absolu pour tester

    elts = charger_valider(path)

    println("Chargement réussi !")
    println("Chemin : ", elts.path)
    println("Contenu brut :")
    println(elts.content)
end

main()
