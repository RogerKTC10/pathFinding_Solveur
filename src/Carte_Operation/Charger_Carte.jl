
struct ChargementGrille
    path :: String
    content :: String
end

function charger_carte(path::String)
    #ICI JE VERIFIE SI LE FIHIER EST .map d'abord, sinon mon programme crache.
    if !endswith(path, ".map")
        error("Le fichier a la mauvaise extension, on ne peut valider le chargerment")
    end
    if !isfile(path)
        error("Ce fichier n'existe pas dans votre structure $path")
    end
    ligne = read(path, String)
    return ChargementGrille(path, ligne)
end

function Integrite(elts::ChargementGrille)
    if isempty(elts.content)
        error("Fichier vide, on a aucun element dans ton fichier")
    end
    return true
end

function entete_certifie(elts::ChargementGrille)
    decoupage = split(elts.content, "\n")
    if !isempty(decoupage)
        doc_type = false
        doc_height = false
        doc_width = false
        doc_map =  false

        for ligne in decoupage
            if startswith(ligne, "type")
                doc_type = true
            elseif startswith(ligne, "height")
                doc_height = true
            elseif startswith(ligne, "width")
                doc_width = true
            elseif startswith(ligne, "map")
                doc_map = true
            end
        end
        if (doc_type == true && doc_height == true && doc_width == true && doc_map == true)
            return true
        else
            error("Fichier map ne respectant pas la norme Moving AI doc")
        end
    end
end

#----Une Pipeline pour faire toute les actions de validation de la carte 

function charger_valider(path::String)
    elts = charger_carte(path)
    if Integrite(elts) && entete_certifie(elts)
        return elts
    end
end

# NB : Ces notes sont pour moi afin de pouvoir me souvenir de ce que j'ai fait au fur a mesur que j'evolue
#=Ici j'ai ecris 2 fonctions qui se charge de faire un filtrage d'integrité et de validité
donc le premiere fonction Charger_Grille() définis la validité du fichier et le second définis l'integrité du fichier, 
ce serait inutile de transformer un fichier vide en matrice car elle sera une matrice vide.
=#
