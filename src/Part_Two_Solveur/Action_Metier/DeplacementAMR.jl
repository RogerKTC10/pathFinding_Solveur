include("AMR.jl")
include("Entrepot_Tri.jl")
include("Fournisseur&Client.jl")
include("../Adaptation/Structure_Part2.jl")

#1 _  on fait le calcul_mission_complete
function calcul_mission_complete(agent::AgentAMR, commande::Commande, carte, G_dict)
    t_initial = 0 
    chemin_aller, cout_1, nodes_1 = execution_Etoile_Adaptation(agent.depart_ag, commande.position_relais, t_initial, carte, G_dict)
    
    t_arrivee_colis = chemin_aller[end].t 
    
    chemin_livraison, cout_2, nodes_2 = execution_Etoile_Adaptation(commande.position_relais, commande.position_droit, t_arrivee_colis, carte, G_dict)

    chemin_total = vcat(chemin_aller, chemin_livraison[2:end])
    
    nouvel_agent = AgentAMR(agent.id_Agent, commande.position_droit, (0,0))
    
    return (trajet = chemin_total,  agent_mis_a_jour = nouvel_agent, cout_total = cout_1 + cout_2, exploration = nodes_1 + nodes_2)
end

function planification_AMR()
end

function Gestion_des_Accidents()
end

function reunir_stat()
end

function retour_final_fin()
end

function affichage_de_mes_sortie()    
end


