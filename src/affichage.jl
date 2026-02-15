import Pkg
Pkg.add("Plots")
using Plots

include("Security_Transformation/Structure.jl")
using .Struct_Carte

function affichage_visible(carte, depart, arriver, chemin, type_Parcours)
    if (type_Parcours == "BFS")
    end
    if (type_Parcours == "Djistkra")
    end
    if (type_Parcours == "A*")
    end
    if (type_Parcours == "Glouton")
    end
end