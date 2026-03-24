function sous_ensemble_gauche(carte::Carte_Final_Value_Struct)
    liste_parking = []
    colonnes_stationnement = [1, 3]
    derniere_ligne = carte.height_val

    for y in 1:derniere_ligne
        for x in colonnes_stationnement
            if x == 3 && (y == 1 || y == derniere_ligne)
                continue 
            end
            if carte.grille[y, x] == '.' 
                push!(liste_parking, (y, x))
            end
        end
    end  
    return liste_parking
end

function zone_relais(carte::Carte_Final_Value_Struct)
    liste_marchandises = []
    
    milieu_x = div(carte.width_val, 2)
    milieu_y = div(carte.height_val, 2)
    
    # On définit la taille du rectangle (ex: 4 colonnes et 6 lignes)
    # Ça veut dire qu'on prend un peu à gauche et un peu à droite du milieu
    for y in (milieu_y - 3):(milieu_y + 3)
        for x in (milieu_x - 2):(milieu_x + 2)
            if y > 0 && y <= carte.height_val && x > 0 && x <= carte.width_val
                if carte.grille[y, x] == '.'
                    push!(liste_marchandises, (y, x))
                end
            end
        end
    end
    
    return liste_marchandises
end


function sous_ensemble_droit(carte::Carte_Final_Value_Struct)
    N = carte.width_val
    liste_quais = []
    
    for y in 1:carte.height_val
        if carte.grille[y, N] == '.' 
            push!(liste_quais, (y, N))
        end
    end
    return liste_quais
end