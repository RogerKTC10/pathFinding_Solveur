function Dictionnaire_Action(Char)
    dic = ['.', '@','T','S', 'W']
    for i in dic
        if i == dic[1] || i == dic[3]
            message = "Zone de blocage, passage refusé"
            return (message, false)
        else
            message = "Passage facile pour le BFS"
           return (message,true)  
        end
    end
end

function Passage_decision()
end