
struct ChargementGrille
    path :: String
    content :: String
end

function charger_Grille(path::String)
    #ICI JE VERIFIE SI LE FIHIER EST .map d'abord, sinon mon programme crache.
    if !endswith(path, ".map")
        error("Le fichier a la mauvaise extension, on ne peut valider le chargerment")
    end
    ligne = read(path, String)
    return ChargementGrille(path, ligne)
end

function valider_chargement(elts::ChargementGrille)
    if isempty(elts.content)
        error("Fichier vide, on a aucun element dans ton fichier")
    end

    println("Validation confirmer: $(elts.path)")
    return true
end
# NB : Ces notes sont pour moi afin de pouvoir me souvenir de ce que j'ai fait au fur a mesur que j'evolue
#=Ici j'ai ecris 2 fonctions qui se charge de faire un filtrage d'integrité et de validité
donc le premiere fonction Charger_Grille() définis la validité du fichier et le second définis l'integrité du fichier, 
ce serait inutile de transformer un fichier vide en matrice car elle sera une matrice vide.
=#
