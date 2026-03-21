module Structure_Part2
export tripletAMR, MissionAMR
    struct tripletAMR
        x::Int
        y::Int
        t::Int
    end

    struct AgentAMR
        id_Agent::Int
        depart_ag::Tuple{Int, Int}
        arrivee_ag::Tuple{Int, Int}
    end
end