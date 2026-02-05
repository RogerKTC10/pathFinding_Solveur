# pathFinding_Solveur 
Mini_ SOLVEUR qui definis un chemin optimal sur une carte 2d avec une vue de graphe.



PROJET SCIENTIFIQUE : SOLUTION LOGICIELLE QUI PERMET DE TROUVER UN MEILLEUR CHEMIN A PARTIR D'UN ALGORITHME
# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- #
« La solution logicielle développée consiste en un programme Julia permettant d’implémenter et de comparer plusieurs algorithmes de recherche de plus court chemin sur une grille 2D contrainte.
Le programme intègre une phase de comparaison au cours de laquelle les algorithmes sont évalués selon différents critères, tels que le coût du chemin obtenu, le nombre de nœuds explorés et l’usage mémoire.
À l’issue de cette comparaison, un classement des algorithmes est proposé afin d’identifier celui offrant le meilleur compromis entre optimalité du chemin, complexité algorithmique et consommation mémoire pour l’instance considérée. »

NB : Ce projet sera réalisé en "Julia" et est présenter comme un projet de scientifique de stage par la L3 INFO-MATHS de Nantes Université.

# --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- #
                            ---°--MON IDEE DE PLAN DE TRAVAIL QUE JE VEUX SUIVRE--°---
                                        ---°--MON DOSSIER "src/"--°---
src/
├── Carte_Oper_Base/
│   ├── charger_carte.jl (fonction: charger(); valider_chargement())
│   │ 
│   └── transformation.jl (fonction: Graphe_correp(), Matrice_valeur_Graphe())
│
├── Solveur_Algos/(Mon dossier pour BFS, Dijkstra, A* avec les etudes préalables d'avance)
│     ├── TasMin.jl (Va prendre en charge la recuperation du nœud ayant la plus petite valuations directement 
│     │   au sommet de notre structure, ce qui va nous faire gagner en complexité(O(1)) par rapport à 
│     │   d'autre algorithme comme celui des AVL. Seuls les algos A* et Djistkra auront besoin de l'utiliser.)
│     │
│     ├── Additional_action.jl (Les fonctions faisons référence au chemins et aux directions de marches en 
│     │   tenant compte des barières auquels on aura affaire.)
│     │
│     ├── Algorithme.jl( Implementer mes algorithmes.)
│    
└── main.jl( Le compilateur général.)
