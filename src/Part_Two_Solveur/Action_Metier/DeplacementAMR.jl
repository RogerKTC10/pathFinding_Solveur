include("AMR.jl")
include("Entrepot_Tri.jl")
include("Fournisseur&Client.jl")

# Utilisation de Structure_Part2. pour lever l'ambiguïté sur les types
function calcul_mission_complete(agent::Structure_Part2.AgentAMR, commande::Structure_Part2.Commande, carte, G_dict)
    t_initial = 0 
    
    # On appelle ton solveur A* (assure-toi que les arguments correspondent à ta définition)
    chemin_aller, cout_1, nodes_1 = execution_Etoile_Adaptation(agent.depart_ag, commande.position_relais, t_initial, carte, G_dict)
    
    t_arrivee_colis = chemin_aller[end].t 
    
    chemin_livraison, cout_2, nodes_2 = execution_Etoile_Adaptation(commande.position_relais, commande.position_droit, t_arrivee_colis, carte, G_dict)

    chemin_total = vcat(chemin_aller, chemin_livraison[2:end])
    
    # On reconstruit l'agent avec sa nouvelle position de fin (le quai)
    nouvel_agent = Structure_Part2.AgentAMR(agent.id_Agent, commande.position_droit, (0,0))
    
    return (trajet = chemin_total, agent_mis_a_jour = nouvel_agent, cout_total = cout_1 + cout_2, exploration = nodes_1 + nodes_2)
end

function planification_AMR(liste_agents, carnet, carte, G_dict)
    archives_missions = [] 
    for i in eachindex(carnet)
        idx_robot = ((i - 1) % length(liste_agents)) + 1
        agent_actuel = liste_agents[idx_robot]
        mission = carnet[i]
        
        res = calcul_mission_complete(agent_actuel, mission, carte, G_dict)
        
        # Utilisation de id_colis_relais comme tu l'as confirmé
        info_precise = (
            id_robot = agent_actuel.id_Agent, 
            id_colis = mission.id_colis_relais, 
            quai_final = mission.id_sous_ensemble_droit, 
            trajet_detaille = res.trajet
        )
        push!(archives_missions, info_precise)
        
        # Mise à jour de l'agent dans la liste pour la prochaine itération
        agent_mis_a_jour = Structure_Part2.AgentAMR(agent_actuel.id_Agent, mission.position_droit, (0,0))
        liste_agents[idx_robot] = agent_mis_a_jour
    end
    
    println("Planification définie : $(length(archives_missions)) missions générées.")
    return archives_missions
end

# Les fonctions suivantes restent pour la structure de ton projet
function Gestion_des_Accidents() end
function reunir_stat() end
function retour_final_fin() end
function affichage_de_mes_sortie() end