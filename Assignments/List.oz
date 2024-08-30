declare  Length Take Drop Append Member Position
    fun {Length List}
        if List == nil then
            0
        else
            1 + {Length List.2}
        end
    end


    % b)

    fun {Take List Count}
        if Count > 0 then
            case List of Head|Tail then
                (Head) | ({Take Tail Count - 1})
            else
                nil
            end
        else
            nil
        end
    end



    % c)
    fun {Drop List Count}
        if Count > 0 then
            case List of _|Tail then
                {Drop Tail Count - 1}
            else
                nil
            end
        else
            List
        
        end
    end


    % d)
    fun {Append List1 List2}
        case List1 of Head|Tail then
            {Append Tail (Head|List2)}
        else
            List2
        end

    end


    % e)
    fun {Member List Element}
        case List of Head|Tail then    end
        end
