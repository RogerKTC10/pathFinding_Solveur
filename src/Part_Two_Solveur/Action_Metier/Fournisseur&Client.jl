include("../Adaptation/Structure_Part2.jl")

using .Structure_Part2

function Carnet_Commande()
    mon_carnet = Structure_Part2.Commande[] 
    return mon_carnet
end

function Generation_Commande(carnet, carte)
    points_relais = zone_relais(carte)      
    points_quais = sous_ensemble_droit(carte)
    
    for i in eachindex(points_relais)
        id_du_colis = i 
        source = points_relais[i]
        idx_quai = ((i - 1) % length(points_quais)) + 1
        destination = points_quais[idx_quai]
        
        # On précise le module pour le constructeur
        nouvelle = Structure_Part2.Commande(id_du_colis, source, idx_quai, destination, false)
        
        push!(carnet, nouvelle)
        println("Commande $i : Case_CMD $source ➔ Case_QUAI $destination (Quai N° $idx_quai)")
    end
    
    println("Total Commande du relais : $(length(carnet)) commandes générées dans le carnet.")
end

global prochain_index = 1

# On précise le module pour les types dans les arguments
function attribution_Commande(agent::Structure_Part2.AgentAMR, carnet::Vector{Structure_Part2.Commande})
    global prochain_index
    
    if prochain_index <= length(carnet)
        mission = carnet[prochain_index]
        
        # On précise le module pour créer le nouvel agent
        agent_mis_a_jour = Structure_Part2.AgentAMR(
            agent.id_Agent, 
            mission.position_relais,
            mission.position_droit)
            
        prochain_index = prochain_index + 1        
        return (agent_mis_a_jour, mission, true)
    else
        return (agent, nothing, false)
    end
end