declare Enumerate GenerateOdd ListDivisorsOf ListPrimesUntil EnumerateLazy Primes in




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

fun {Enumerate Start End} UTail in
    thread 
        if Start =< End then
            thread UTail = {Enumerate Start+1 End} end
            Start|UTail
        else 
            nil
        end
    end
end

{Browse {Enumerate 1 5}}

fun {GenerateOdd Start End} IntList in 
    IntList = {Enumerate Start End}
    thread {List.foldR IntList fun {$ X Y} if {Int.isOdd X} 
        then X|Y 
        else Y end 
    end nil }
    end
end

{Browse {GenerateOdd 1 5}}

{Show {Enumerate 1 5}}
{Show {GenerateOdd 1 5}}

{System.showInfo "Task 3"}
fun { ListDivisorsOf Number} NumberList in
    NumberList = { Enumerate 1 Number}
    thread { List.foldR NumberList fun {$ X Y} if { Int.'mod' Number X} == 0 then X | Y else Y end end
    nil } end
    end


{Show {ListDivisorsOf 10}}

fun {ListPrimesUntil N} NumberList in
    NumberList = { Enumerate 1 N}
    thread { List.foldR NumberList fun {$ X Y} thread if
    { List.length { ListDivisorsOf X}} == 2 then X |
    Y else Y end end end nil } end
    end

{Show {ListPrimesUntil 300}}

{System.showInfo "Task 4"}

fun {EnumerateLazy} Func in
    fun lazy {Func N}
        N | {Func N+1}
    end
   1 | {Func 2}
end

{Browse {EnumerateLazy}}


fun {Primes} Func StartNumberList in
    fun lazy {Func N NumberList}
        case NumberList of H | T then
            case {ListDivisorsOf N} of _|_|_|_ then
                {Func H T}
            else
                N | {Func H T}
            end
        end
    end
    StartNumberList = {EnumerateLazy}
    case StartNumberList of _|X2|X3|T then
        X2 | {Func X3 T}
    end
end

{Show {Primes}}