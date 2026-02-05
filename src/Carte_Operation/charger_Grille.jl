
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