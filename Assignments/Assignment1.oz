functor
import 
    System
define
    % Task 1
    {System.showInfo 'Hello World'}

    % Task 3

    % a)
    local X Y=300 Z=30 in
        X = Y * Z
        {System.showInfo X}
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
    fun {Max Number1 Number2}
        if Number1 > Number2 then
            Number1
        else
            Number2
        end
    end
    % b) using the already defined function Max in the procedure PrintGreater

    proc {PrintGreater Number1 Number2}
        {System.showInfo {Max Number1 Number2}}
    end

    {PrintGreater 10 20}

    % Task 5

    proc {Circle R} Area Diameter Circumference PI=355.0/113.0 in
        Area = PI * R * R
        Diameter = 2.0 * R
        Circumference = PI * Diameter
        {System.showInfo Area}
        {System.showInfo Diameter}
        {System.showInfo Circumference}
    end

    {Circle 10.0}


    % Task 6
    % a)
    fun {Factorial N}
        if N == 0 then
            1
        else
            N*{Factorial N-1}
        end
    end

    {System.showInfo {Factorial 5}}

    % Task 7
    % a)
    fun {Length List}
        if List == nil then
            0
        else
            1 + {Length List.2}
        end
    end

    {System.showInfo {Length [1 2 3 4 5 6]}}

    % b)
    

end
    