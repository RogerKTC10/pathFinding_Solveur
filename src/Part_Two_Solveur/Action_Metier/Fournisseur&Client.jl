include("../Adaptation/Structure_Part2.jl")

using .Commande

function Carnet_Commande()
    mon_carnet = Commande[]
    return mon_carnet
end

function Generation_Commande(carnet, carte)
    
    points_relais = zone_relais(carte)      
    points_quais = sous_ensemble_droit(carte)
    
    for i in eachindex(points_relais)
        source = points_relais[i]
        idx_quai = ((i - 1) % length(points_quais)) + 1
        destination = points_quais[idx_quai]
        
        nouvelle = Commande(i, source, destination, false)
        
        push!(carnet, nouvelle)
    end
    
    println("Initialisation : $(length(carnet)) commandes générées dans le carnet.")
end

global prochain_index = 1
function attribution_Commande(agent::AgentAMR, carnet::Vector{Commande})
    global prochain_index
    
    if prochain_index <= length(carnet)
        mission = carnet[prochain_index]
        
        agent_mis_a_jour = AgentAMR(agent.id_Agent, mission.position_relais, mission.positio_droit)
        prochain_index += 1
        
        return (agent_mis_a_jour, true)
    else
        return (agent, false)
    end
end