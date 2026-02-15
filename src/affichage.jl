import Pkg
Pkg.add("Plots")
using Plots

#include("Security_Transformation/Structure.jl")
#using .Struct_Carte

function affichage_BFS(carte, chemin)
    grille_recup  = zeros(Int, carte.height, carte.width)
    for i in 1:carte.height
        for j in 1:carte.width
            if carte.grille[i,j] == '@'
                grille_recup[i, j] = 1
            else
                grille_recup[i, j] = 0
            end
        end
    end

    affich = heatmap(grille_recup,
                  color = cgrad([:lightgrey, :brown]),
                  yflip = true,
                  aspect_ratio = :equal,
                  legend = false)
    if !isempty(chemin)
       x_coords = Int[]
       y_coords = Int[] 
       for (i, j) in chemin 
            push!(x_coords, j) 
            push!(y_coords, i)
       end 
       plot!(affich, x_coords, y_coords, 
              color = :blue, 
              linewidth = 3, 
              label = "Chemin BFS")
    end
    display(affich)
                        
end