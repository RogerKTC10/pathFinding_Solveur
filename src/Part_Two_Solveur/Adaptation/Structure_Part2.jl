module Structure_Part2
export tripletAMR, AgentAMR, Commande
    struct tripletAMR
        y::Int
        x::Int
        t::Int
    end

    struct AgentAMR
        id_Agent::Int
        depart_ag::Tuple{Int, Int}
        arrivee_ag::Tuple{Int, Int}
    end

#----------Partie de Commande------
    struct Commande
        id_colis_relais::Int
        position_relais::Tuple{Int, Int}
        positio_droit::Tuple{Int, Int}
        accomplie::Bool
    end
end