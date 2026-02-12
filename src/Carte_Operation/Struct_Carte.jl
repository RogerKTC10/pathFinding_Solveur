module  Struct_Carte
   export ChargementGrille

    struct ChargementGrille
        path :: String
        content :: String
    end

    struct Carte_final_Struct
        grille::Matrix{char}  
        commencer::Tuple{Int,Int}
        final::Tuple{Int,Int} 
    end
    
end
