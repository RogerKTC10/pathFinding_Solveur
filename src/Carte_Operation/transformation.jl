include("Chargement.jl")

function scinder(elts::ChargementGrille)
    decide, lignes = entete_certifie(elts)
    if decide
       debut = 1:4
       rest = 5:length(lignes)

       entete = lignes[debut]
       apres_entete = lignes[rest]

        return (entete, apres_entete)
    end
end

#=function Extraction(path::String)
    recup_heigth = 0
    recup_width = 0
    recup_map = 0
    contenu = charger_valider(path)
    if contenu 

    end

end=#

function nonAlterer()
end

function Matrice_Cons()
end

function Matrice_Value()
end