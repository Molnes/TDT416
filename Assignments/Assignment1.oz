   % Task 1
    {Show 'Hello World'}

    % Task 3

    % a)
    local X Y=300 Z=30 in
        X = Y * Z
        {Show X}
    end


    % b)
    local Y X in
        X = "This is a string"
        thread {System.showInfo Y} end
        Y = X
    end
    % Why do you think showInfo can print Y before it is assigned?
    % In Oz when something tries to access an unbound variable, it will wait instead of erroring out.
    % When Y is bound to X, the thread will print out the value of X.
    % It won't block/wait on the main thread because we set it to run in a separate thread.

    % Why is this behaviour useful?
    % It is useful because it allows for easier multithreading and concurrency without having to worry about crashing the program when something unboud is accessed.
    % Like Race Conditions in other languages.

    % What does the statement Y = X do?
    % It binds the value of X to Y.






    % Task 4
    % a)
local Max PrintGreater in
    fun {Max Number1 Number2}
        if Number1 > Number2 then
            Number1
        else
            Number2
        end
    end
    % b) using the already defined function Max in the procedure PrintGreater

    proc {PrintGreater Number1 Number2}
        {Show {Max Number1 Number2}}
    end

    {PrintGreater 10 20}
end

    % Task 5
local Circle in
    proc {Circle R} Area Diameter Circumference PI=355.0/113.0 in
        Area = PI * R * R
        Diameter = 2.0 * R
        Circumference = PI * Diameter
        {Show Area}
        {Show Diameter}
        {Show Circumference}
    end

    {Circle 10.0}
end


    % Task 6
    % a)
local Factorial in
    fun {Factorial N}
        if N == 0 then
            1
        else
            N*{Factorial N-1}
        end
    end

    {Show {Factorial 5}}
end

    % Task 7
    % a)
local Length Take Drop Append Member Position in
    fun {Length List}
        if List == nil then
            0
        else
            1 + {Length List.2}
        end
    end

    {Show {Length [1 2 3 4 5]}}

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
    {Show {Take [1 2 3 4 5] 3}}


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

        {Show {Drop [1 2 3 4 5] 3}}
        {Show {Drop [1 2 3 4 5] 6}}
        {Show {Drop [1 2 3 4 5] 0}}

    % d)
    fun {Append List1 List2}
        case List1 of Head|Tail then
            {Append Tail (Head|List2)}
        else
            List2
        end

    end

    {Show {Append [1 2 3] [4 5 6]}}


    % e)
    fun {Member List Element}
        case List of Head|Tail then
            if Head == Element then
                true
            else
                {Member Tail Element}
            end
        else
            false
        end
    end

    {Show {Member [1 2 3 4 5] 2}}

    % f)
    fun {Position List Element}
        case List of Head|Tail then
            if Head == Element then
                1
            else
                1 + {Position Tail Element}
            end
        end
    end

    {Show {Position [1 2 3 4 5] 3}}
    {Show {Position [3 1 2 4 5] 1}}

    {Show {Position [5 1 2 4 3] 4}}
end


% Task 8
% a)
local Push Peek Pop in
fun {Push List Element}
    Element|List
end

{Show {Push [1 2 3] 4}}

% b)
fun {Peek List}
    case List of Head|Tail then
        Head
    else
        nil
    end
end

{Show {Peek [1 2 3 4 5]}}


% c)
fun {Pop List}
    case List of Head|Tail then
        Tail
    else
        nil
    end
end

{Show {Pop [1 2 3 4 5]}}

end