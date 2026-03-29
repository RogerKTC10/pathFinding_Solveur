include("Security_Transformation/Transformation.jl")
include("Comparaison.jl") 
include("My_Algorithms/DataStructure_Min.jl")
include("My_Algorithms/BFS_Doc/BFS.jl")
include("My_Algorithms/Djistkra_Doc/Djistkra.jl")
include("My_Algorithms/Glouton_Doc/Glouton.jl")
include("My_Algorithms/A_Doc/A_etoile.jl")

#PARTIE 2 DU CROSS-DOCKING PROJECT
include("Part_Two_Solveur/Adaptation/Evolution_A_etoile.jl")
include("Part_Two_Solveur/Utilitaire_Part2.jl")
include("Part_Two_Solveur/Action_Metier/DeplacementAMR.jl")


function main()
    path = "data/street-map/Boston_0_512.map"
    matrice = Remplir_Matrice_Cons(path)
    matriceV = Remplir_Matrice_Value(matrice)

    carte = Struct_Carte.Constructeur_Matrice_Value(matriceV)
    carnet = Carnet_Commande()

    Generation_Commande(carnet, carte)

    parking_AMR = sous_ensemble_gauche(carte)
    # On crée les agents (AgentAMR) au parking
    liste_agents = [AgentAMR(i, parking[i], (0, 0)) for i in 1:20]
    println("✅ 20 Agents prêts au départ (Colonne 1).")

    # --- ÉTAPE 4 : PLANIFICATION ---
    # Ici, G_dict peut être 'nothing' ou ta matriceV, 
    # car ton A* pioche déjà dans 'carte.grille_val'
    println("\nCalcul des missions en cours...")
    
    archives = planification_AMR(liste_agents, carnet, carte, nothing)

    # --- ÉTAPE 5 : RÉSULTATS ---
    println("\n--- BILAN DE LA SIMULATION ---")
    println("Nombre total de missions : $(length(archives))")
    
    # Petit test de lecture sur la première mission
    if !isempty(archives)
        m1 = archives[1]
        println("Robot $(m1.id_robot) -> Colis $(m1.id_colis) livré au quai $(m1.quai_final)")
        println("Durée totale (temps discret) : $(m1.trajet_detaille[end].t)")
    end

















    """path = "data/street-map/Boston_0_512.map"
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
    println("\n")"""
    
end

main()