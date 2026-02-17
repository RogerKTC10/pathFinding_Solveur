using .DataStructure_Min
using .Struct_Carte
using DataStructures


function execution_Djisktra(G::Carte_Final_Value_Struct, vdepart, varriver)
    matriceDjis = G.grille_val  #Iici je considère ma matrice comme un graphe dont les sommet sont les cases et les arretes sont les deplacement Nord, Ouest, Est, Sud a faire sur la carte ... 
    h, w = G.height_val, G.width_val

    distance_djis = Dict{Tuple{Int, Int}, Float64}()
    distance_djis[vdepart] = 0.0

    parents = Dict{Tuple{Int, Int}, Tuple{Int, Int}}()
    visiter = Set{vdepart}
    
    noeud = tas_min()

end