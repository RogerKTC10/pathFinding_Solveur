#=include("AMR.jl")
include("Entrepot_Tri.jl")
include("Fournisseur&Client.jl")=#

using .Structure_Part2

function calcul_mission_complete(agent::Structure_Part2.AgentAMR, commande::Structure_Part2.Commande, carte, G_dict, intervalles_dict, t_depart::Int)
     t_initial = t_depart 
    
     depart = (Int(agent.depart_ag[1]), Int(agent.depart_ag[2]))
     relais = (Int(commande.position_relais[1]), Int(commande.position_relais[2]))
     arrivee = (Int(commande.position_droit[1]), Int(commande.position_droit[2]))

     chemin_aller, cout_1, nodes_1 = execution_Etoile_Adaptation(carte, depart, relais, G_dict, intervalles_dict, t_initial)

     if isempty(chemin_aller)
        return nothing
     end
     
     t_arrivee_relais = chemin_aller[end].t 

     chemin_livraison, cout_2, nodes_2 = execution_Etoile_Adaptation(carte, relais, arrivee, G_dict, intervalles_dict, t_arrivee_relais)
     if isempty(chemin_livraison)
        return nothing
     end 

     chemin_total = vcat(chemin_aller, chemin_livraison[2:end])
     nouvel_agent = Structure_Part2.AgentAMR(agent.id_Agent, arrivee, (0,0))    
     
     return (trajet = chemin_total, agent_mis_a_jour = nouvel_agent, cout_total = cout_1 + cout_2, exploration = nodes_1 + nodes_2)
end

function Mise_a_jour_Intervalles!(intervalles_dict, trajet)
    for point in trajet
        pos = (Int(point.y), Int(point.x))
        t_occupe = Int(point.t)
        if haskey(intervalles_dict, pos)
            intervalles_actuels = intervalles_dict[pos]
            nouveaux = Vector{Tuple{Int, Int}}()
            for (debut, fin) in intervalles_actuels
                if t_occupe >= debut && t_occupe <= fin
                    if t_occupe > debut
                        push!(nouveaux, (debut, t_occupe - 1))
                    end
                    if t_occupe < fin
                        push!(nouveaux, (t_occupe + 1, fin))
                    end
                else
                    push!(nouveaux, (debut, fin))
                end
            end
            intervalles_dict[pos] = nouveaux
        end
    end
end

function planification_AMR(liste_agents, carnet, carte, G_dict, intervalles_dict)
    archives_missions = [] 
    
    # ÉTAPE CLÉ : On crée un tableau de 15 zéros (un chrono par robot)
    temps_fin_robots = zeros(Int, length(liste_agents)) 
    
    for i in eachindex(carnet)
        idx_robot = ((i - 1) % length(liste_agents)) + 1
        agent_actuel = liste_agents[idx_robot]
        mission = carnet[i]
        
        # On récupère l'heure de départ de CE robot précis
        t_start = temps_fin_robots[idx_robot]
        
        # On calcule la mission en partant de t_start
        res = calcul_mission_complete(agent_actuel, mission, carte, G_dict, intervalles_dict, t_start)
        
        if res !== nothing && res.cout_total < 50000
            Mise_a_jour_Intervalles!(intervalles_dict, res.trajet)
            
            # On enregistre la mission
            info_precise = (id_robot = agent_actuel.id_Agent, id_colis = mission.id_colis_relais, quai_final = mission.numero_sous_ensDroit, trajet_detaille = res.trajet, duree = res.cout_total)
            push!(archives_missions, info_precise)
            
            # MISE À JOUR : 
            # 1. Le robot change de place (il est au quai)
            liste_agents[idx_robot] = res.agent_mis_a_jour
            # 2. On met à jour son horloge pour la mission suivante !
            temps_fin_robots[idx_robot] = res.trajet[end].t
        else
            println("Mission $i (Robot $(agent_actuel.id_Agent)) : Impossible à T=$t_start")
        end
    end
    return archives_missions, temps_fin_robots
end

function reunir_stats(archives_missions)
    if isempty(archives_missions)
        println("Aucune mission n'a été effectuée.")
        return
    end
    
    total_temps = 0
    total_pas = 0
    missions_par_robot = Dict{Int, Int}()

    for m in archives_missions
        if m.duree < Inf
            total_temps += m.duree
            total_pas = total_pas + length(m.trajet_detaille)
            id = m.id_robot
            missions_par_robot[id] = get(missions_par_robot, id, 0) + 1
        end
    end

    println("\n" * "="^80)
    println("BILAN GÉNÉRAL DES MISSIONS (CARTE BERLIN)")
    println("Total : ", length(archives_missions), " missions | Distance : ", total_pas, " cases | Moyenne : ", round(total_temps / length(archives_missions), digits=2))
    println("="^80)

    println("\nRépartition de la charge de travail :")
    
    ids = sort(collect(keys(missions_par_robot)))

    print("  AMR N°    : ") 
    for id in ids
        print("| ", rpad(id, 2), " ")
    end
    println("|")

    print("              ") 
    for _ in ids
        print("-----")
    end
    println("-")

    print(" Nbre MISS  : ") 
    for id in ids
        print("| ", rpad(missions_par_robot[id], 2), " ")
    end
    println("|")
    println("-"^((length(ids)*5)+15))
end


function mission_retour_parking(liste_agents, positions_initiales, carte, G_dict, intervalles_dict, temps_fin_robots)
    for i in eachindex(liste_agents)
        agent_actuel = liste_agents[i]
        parking_cible = positions_initiales[i]
        t_depart = temps_fin_robots[i]

        chemin_ret, cout_ret, nodes_ret = execution_Etoile_Adaptation(carte, agent_actuel.depart_ag, parking_cible, G_dict, intervalles_dict, t_depart)
        if !isempty(chemin_ret)
           Mise_a_jour_Intervalles!(intervalles_dict, chemin_ret)
           liste_agents[i] = Structure_Part2.AgentAMR(agent_actuel.id_Agent, parking_cible, (0,0))
        end
    end
     println("Tous les robots sont retourner a la zone de Parking")
end

