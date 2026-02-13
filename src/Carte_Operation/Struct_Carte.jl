module  Struct_Carte
   export ChargementGrille, Carte_final_Struct, Constructeur_Matrice_Cons

    struct ChargementGrille
        path :: String
        content :: String
    end

    struct Carte_final_Struct
        grille::Matrix{Char}  
        height::Int
        width::Int
    end

    #-----------CONSTRUCTEUR MATRICE_CONS DIRECTE-----------#

    function Constructeur_Matrice_Cons(grille::Matrix{Char})
        Carte_final_Struct(
            grille
            #=, 
            size(grille, 1),
            size(grille, 2)=#)
    end
end
