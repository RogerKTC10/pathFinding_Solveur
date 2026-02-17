
function execution_BFS(carte::Struct_Carte.Carte_final_Struct, depart, arriver)
    file = [depart]                 
    visites = Set([depart])               
    parents = Dict()
    nb_etats_evalues = 0
    trouve = false
    while !isempty(file)
        (i, j) = popfirst!(file)
        nb_etats_evalues += 1
        if ((i, j) == arriver)
            trouve = true
            break
        end
        for voisin in Voisinage(i, j)
            (ni, nj) = voisin   
            if (ni >= 1 && ni <= carte.height && nj >= 1 && nj <= carte.width)
                caractere_case = carte.grille[ni, nj]
                
                message, autorise = BFS_dic_Action(caractere_case)
                
                if autorise
                    if !(voisin in visites)
                        push!(visites, voisin)
                        
                        parents[voisin] = (i, j) 
                        push!(file, voisin)
                    end
                end
            end
        end
    end
    if trouve
        chemin_final = reconstruire_chemin(parents, depart, arriver)
        return (chemin = chemin_final, activite = nb_etats_evalues, distance = length(chemin_final)-1)
    else
        println("Pas de chemin trouvé.")
        return (chemin = [], activite = nb_etats_evalues, distance = -1)
    end
end