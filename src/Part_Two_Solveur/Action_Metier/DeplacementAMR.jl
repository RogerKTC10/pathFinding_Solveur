include("AMR.jl")
include("Entrepot_Tri.jl")
include("Fournisseur&Client.jl")

function calcul_mission_complete(agent::AgentAMR, commande::Commande, carte, G_dict)
    t_initial = 0 
    chemin_aller, cout_1, nodes_1 = execution_Etoile_Adaptation(agent.depart_ag, commande.position_relais, t_initial, carte, G_dict)
    
    t_arrivee_colis = chemin_aller[end].t 
    
    chemin_livraison, cout_2, nodes_2 = execution_Etoile_Adaptation(commande.position_relais, commande.position_droit, t_arrivee_colis, carte, G_dict)

    chemin_total = vcat(chemin_aller, chemin_livraison[2:end])
    
    nouvel_agent = AgentAMR(agent.id_Agent, commande.position_droit, (0,0))
    
    return (trajet = chemin_total,  agent_mis_a_jour = nouvel_agent, cout_total = cout_1 + cout_2, exploration = nodes_1 + nodes_2)
end

function planification_AMR(liste_agents, carnet, carte, G_dict)
    archives_missions = [] 
    for i in eachindex(carnet)
        idx_robot = ((i - 1) % length(liste_agents)) + 1
        agent_actuel = liste_agents[idx_robot]
        mission = carnet[i]
        
        res = calcul_mission_complete(agent_actuel, mission, carte, G_dict)
        
        info_precise = (id_robot = agent_actuel.id_Agent, id_colis = mission.id_colis_relais, quai_final = mission.id_sous_ensemble_droit, trajet_detaille = res.trajet)
        push!(archives_missions, info_precise)
        
        agent_mis_a_jour = AgentAMR(agent_actuel.id_Agent, mission.position_droit,(0,0))
        
        liste_agents[idx_robot] = agent_mis_a_jour
    end
    println("Planification definie : $(length(archives_missions)) des missions.")
    return archives_missions
end

function Gestion_des_Accidents()
end

function reunir_stat()
end

function retour_final_fin()
end

function affichage_de_mes_sortie()    
end


