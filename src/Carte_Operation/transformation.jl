include("Chargement.jl")

function scinder(elts::ChargementGrille)
    decide, lignes = entete_certifie(elts)
    if !isnothing(decide)
       debut = 1:4
       rest = 5:length(lignes)

       entete = lignes[debut]
       apres_entete = lignes[rest]

        return (entete, apres_entete)
    end
end

function Extraction(path::String)
    contenu = charger_valider(path)
    if !isnothing(contenu)
        entete, apres_entete = scinder(contenu)
        recup_heigth = parse(Int, split(entete[2])[2])
        recup_width = parse(Int, split(entete[3])[2])

        nettoyage = [strip(l) for l in apres_entete if !isempty(strip(l))]
        return (recup_heigth, recup_width, nettoyage)
    end
end

function nonAlterer(nettoyage, v_height, v_width)
    if length(nettoyage) != v_height
        error("Hauteur altéré")
    end
    
    for i in eachindex(nettoyage)
        if length(nettoyage[i]) != v_width
            error("Largeur altéré à la ligne $i")
        end
    end
    return true
end

#--------------------------------------ALLOCATION MEMEOIRE DES MATRICE-------------------------
function Matrice_Cons(h::Int64, w::Int64)
    return Matrix{Char}(undef, h, w)
end

function Matrice_Value()
end
#------------------------------------REMPLIR LES LIGNES ET COLONNES DE LA MATRICE----------------
function Remplir_Matrice_Cons(path::String)
    contenu = Extraction(path)
    if !isnothing(contenu)
        h, w, donnee_recup = contenu
        if nonAlterer(donnee_recup, h, w)
             matriceCons = Matrice_Cons(h, w)

             return matriceCons
        end
    else
        error("Echec d'extraction")
    end
end

