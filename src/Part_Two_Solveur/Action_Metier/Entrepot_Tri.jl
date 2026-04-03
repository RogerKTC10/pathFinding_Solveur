function sous_ensemble_gauche(carte::Struct_Carte.Carte_Final_Value_Struct)
    liste_parking = []
    for x in 1:15
        for y in 1:carte.height_val
            if carte.grille_val[y, x] == 1.0
                push!(liste_parking, (y, x))
                if length(liste_parking) >= 15
                    return liste_parking
                end
            end
        end
    end
    return liste_parking
end

function zone_relais(carte::Struct_Carte.Carte_Final_Value_Struct)
    liste_marchandises = []
    milieu_x = div(carte.width_val, 2)
    milieu_y = div(carte.height_val, 2)
    for y in (milieu_y - 10):(milieu_y + 9)
        for x in (milieu_x - 10):(milieu_x + 9)
            if y > 0 && y <= carte.height_val && x > 0 && x <= carte.width_val
                if carte.grille_val[y, x] == 1.0
                    push!(liste_marchandises, (y, x))
                end
            end
        end
    end
    return liste_marchandises
end

function sous_ensemble_droit(carte::Struct_Carte.Carte_Final_Value_Struct)
    N = carte.width_val
    liste_quais = []
    for x in (N-15):N
        for y in 1:carte.height_val
            if carte.grille_val[y, x] == 1.0 
                push!(liste_quais, (y, x))
                if length(liste_quais) >= 15
                    return liste_quais
                end
            end
        end
    end
    return liste_quais
end