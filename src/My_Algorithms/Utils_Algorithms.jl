function BFS_dic_Action(i::Char)
        if i == '.' || i == 'T'
            return ("Zone de blocage, passage refusé", false)
        elseif i == '.' || i == 'S' || i == 'W'
           return ("Passage facile pour le BFS", true)
        else
           return ("Caractère inconnu", false)  
        end
end

function Passage_decision()
end