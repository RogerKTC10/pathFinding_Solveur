using .Structure_Part2

function valider_agent_sur_carte(agent::AgentAMR, G_dict)
    return BFS_Action_dict(agent.depart_ag[1], agent.depart_ag[2], G_dict) &&
           BFS_Action_dict(agent.arrivee_ag[1], agent.arrivee_ag[2], G_dict)
end

function recuperer_etat_t(chemin::Vector{tripletAMR}, t::Int)
     
end