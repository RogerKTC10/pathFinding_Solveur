using .Struct_Carte

function algo_BFS(carte::Carte_final_Struct, pt_depart, pt_arriver)
    file = [pt_depart]
    visite = Set[pt_arriver]
    dic_stock = Dict()
    value = 0
    vue = false

    while(!isempty(file))
        actuel = shift!(file)
        nb_etats_evalues += 1 
        if actuel == goal 
            vue = true 
            break 
        end #je laisse ca en suspend ... Je continuerai demain
    end

end