declare Enumerate in


% Task 1

{System.showInfo "Task 1"}
local A=10 B=20 C=30 in
    {System.show C}
    
    thread
        {System.show A}
        {Delay 100}
        {System.show A * 10}
    end

    thread
        {System.show B}
        {Delay 100}
        {System.show B * 10}
    end

    
    {System.show C * 100}
end


{System.showInfo "Task 1c"}

local A B C in
    thread
        A = 2
        {System.show A}
    end
    
    thread
        B = A * 10
        {System.show B}
    end

    C = A + B
    {System.show C}
end


{System.showInfo "Task 2"}

fun {Enumerate Start End}
    if Start =< End then
        {System.show Start}
        {Enumerate Start+1 End}
    else 
        nil
    end
end

{Browse {Enumerate 1 5}}