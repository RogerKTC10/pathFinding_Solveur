# --- main.jl ---

include("Part_Two_Solveur/Adaptation/Structure_Part2.jl")
using .Structure_Part2
include("./Security_Transformation/Structure.jl") 
using .Struct_Carte
include("Part_Two_Solveur/Action_Metier/DeplacementAMR.jl")

function main()
    # 1. Préparation de la Carte
    path = "data/street-map/Boston_0_512.map"
    matrice = Remplir_Matrice_Cons(path)
    matriceV = Remplir_Matrice_Value(matrice)
    carte = Struct_Carte.Constructeur_Matrice_Value(matriceV)
    
    # 2. DÉFINITION DES ZONES (C'est ici que ça se passe)
    # On appelle tes fonctions métier pour identifier les points sur la carte
    parking_points = sous_ensemble_gauche(carte)
    relais_points  = zone_relais(carte)  # <--- LA VOILÀ, TA ZONE RELAIS
    quais_points   = sous_ensemble_droit(carte)

    # 3. CRÉATION PHYSIQUE DES ROBOTS (AMR)
    # On transforme les points de parking en objets "AgentAMR"
    liste_agents = [Structure_Part2.AgentAMR(i, parking_points[i], (0, 0)) for i in 1:length(parking_points)]
    
    # 4. CRÉATION DU CARNET DE COMMANDES
    carnet = Carnet_Commande()
    # On remplit le carnet en utilisant les zones qu'on vient de trouver
    Generation_Commande(carnet, carte) 

    # 5. VÉRIFICATION ET SIMULATION
    println("--- ÉTAT DU SYSTÈME ---")
    println("Robots en zone parking : $(length(liste_agents))")
    println("Points dans zone_relais : $(length(relais_points))")
    println("Commandes générées     : $(length(carnet))")
    
    if !isempty(liste_agents) && !isempty(carnet)
        println("\n🚀 Lancement de la planification...")
        archives = planification_AMR(liste_agents, carnet, carte, nothing)
        println("Simulation terminée avec succès.")
    else
        println("❌ ERREUR : La zone_relais ou le parking est vide sur Boston_0_512.")
    end
end

main()

#=include("Security_Transformation/Transformation.jl")
    include("Comparaison.jl") 
    include("My_Algorithms/DataStructure_Min.jl")
    include("My_Algorithms/BFS_Doc/BFS.jl")
    include("My_Algorithms/Djistkra_Doc/Djistkra.jl")
    include("My_Algorithms/Glouton_Doc/Glouton.jl")
    include("My_Algorithms/A_Doc/A_etoile.jl")
    
    path = "data/street-map/Boston_0_512.map"
    matrice = Remplir_Matrice_Cons(path)
    matriceV = Remplir_Matrice_Value(matrice)

    carte = Struct_Carte.Constructeur_Matrice_Cons(matrice)
    carteValuer = Struct_Carte.Constructeur_Matrice_Value(matriceV)

    depart, arriver = trouver_points_pieges(matrice)


    println("Lancement BFS...")
    debut_bfstime = time()
    res_bfs = execution_BFS(carte, depart, arriver)
    temps_bfs = CPUtime(debut_bfstime)
    cout_reel_bfs = calculer_cout_chemin(res_bfs.chemin, matrice)


    println("Lancement Dijkstra...")
    debut_djistime = time()
    res_djis = execution_Djisktra(carteValuer, depart, arriver)
    temps_djis = CPUtime(debut_djistime)
    
    println("Lancement Glouton...")
    debut_glouton = time()
    res_glouton = execution_Glouton(matrice, matriceV, depart, arriver)
    temps_glouton = CPUtime(debut_glouton)

    println("Lancement A*...")
    debut_astartime = time()
    res_etoile = execution_Etoile(carteValuer, depart, arriver) # Ta fonction A*
    temps_etoile = CPUtime(debut_astartime)


    println("Solution BFS: \n")
    println("Distance BFS: $cout_reel_bfs \n")
    println("Etats BFS: $(res_bfs.activite)\n")
    println("CPUtime BFS: $(temps_bfs)\n")
    println("Les points du chemin BFS sont : \n", res_bfs.chemin)
    println("\n")

    println("Solution Djisktra: \n")
    println("Distance Djisktra: $(res_djis.cout)\n")
    println("Etats Djiskstra: $(res_djis.activite)\n")
    println("CPUtime Djiskstra: $(temps_djis)\n")
    println("Les points du chemin Djikstra sont : \n", res_djis.chemin)
    println("\n")
    
    println("Solution Glouton: \n")
    println("Distance Glouton: $(res_glouton.distance)\n")
    println("Etats Glouton: $(res_glouton.activite)\n")
    println("CPUtime Glouton: $(temps_glouton)\n")
    println("Les points du chemin Glouton sont : \n", res_glouton.chemin)
    println("\n")

    println("Solution A*: \n")
    println("Distance A*: $(res_etoile.cout)\n")
    println("Etats A*: $(res_etoile.activite)\n")
    println("CPUtime A*: $(temps_etoile)\n")
    println("Les points du chemin A* sont : \n", res_etoile.chemin)
    println("\n")=#
    