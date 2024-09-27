declare QuadraticEquation Sum RightFold Quadratic LazyNumberGenerator in

% a)
proc {QuadraticEquation A B C ?RealSol ?X1 ?X2} Delta in
    Delta = B*B - 4.0*A*C
    if Delta > 0.0 then
        X1 = (~B + {Float.sqrt Delta}) / (2.0*A)
        X2 = (~B - {Float.sqrt Delta}) / (2.0*A)
        RealSol = true
    elseif Delta == 0.0 then
        X1 = ~B / (2.0*A)
        X2 = ~B / (2.0*A)
        RealSol = true
    else
        RealSol = false
    end
end
% b)
local RealSol X1 X2 in
    {QuadraticEquation 2.0 1.0 ~1.0 RealSol X1 X2}
    {System.show [RealSol X1 X2]}
end

local RealSol X1 X2 in
    {QuadraticEquation 2.0 1.0 2.0 RealSol X1 X2}
    {System.show [RealSol X1 X2]}
end

% c)
% Why are procedual abstractions useful?
% Procedual abstractions are useful because they let us define a procedure that can be called multiple times with different arguments. This is useful because it allows us to reuse code and make it more readable.

% d)
% What is the difference between a procedure and a function?
% In Oz a procedure is a block of code that can be called multiple times with different arguments, while a function is a block of code that can be called multiple times with different arguments and returns a value.

% Task 2
fun {Sum List}
    case List
        of nil then 0
        [] H|T then H + {Sum T}
    end
end

{System.show {Sum [1 2 3 4 5]}}

% Task 3
% a)
fun {RightFold List Op U}
    case List 
        of nil then U
        [] H|T then {Op H {RightFold T Op U}}
    end
end

% b)
% Explain each line of the code in RightFold in your own words.
% The first line defines a function called RightFold that takes three arguments: List, Op, and U. 
    %The second line starts a case statement that checks the list.
    %The third line checks if the list is empty and returns U if it is.
    % The fourth line checks if it is a non-empty list and applies the operation Op to the head of the list and the result of recursively calling RightFold on the tail of the list with the same operation and U.
    % The fifth line ends the case statement.
    % The sixth line ends the function definition.

% c)
local Length Sum in
    fun {Length List} 
        {RightFold List fun {$ X Y} 1+Y end 0}
    end

    fun {Sum List}
        {RightFold List fun {$ X Y} X+Y end 0}
    end

    {System.show {Length [1 2 3 4]}}
    {System.show {Sum [1 2 3 4]}}
end

% d)
% For the Sum and Lenght operations, would LeftFold (a left-associative fold) and RightFold give different
% results? Can you provide an example of an operation for which the two folds do not produce the same result?

% In our case, LeftFold and RightFold would give the same result since we only use additive operations.
% There would be different results if we used subtraction or division operations, since they change based on the order of the operations.

% e)
% What is an appropriate value for U when using RightFold to implement the product of list elements?
% The appropriate value for U when using RightFold to implement the product of list elements is 1, since multiplying by 1 does not change the value of the product.

% Task 4
fun {Quadratic A B C}
    fun {$ X}
        A*X*X + B*X + C
    end
end

{System.show {{Quadratic 3.0 2.0 1.0} 2.0}}

% Task 5
fun {LazyNumberGenerator StartValue}
    number(StartValue
    fun {$} {LazyNumberGenerator StartValue+1} end)
end

{System.show {LazyNumberGenerator 0}.1}
{System.show {{LazyNumberGenerator 0}.2}.1}
{System.show {{{{{{LazyNumberGenerator 0}.2}.2}.2}.2}.2}.1}

% b)
% Give a high-level desciption of your solution and point out any limitations you find relevant
% We define a function LazyNumberGenerator that takes a StartValue as an argument and returns a tuple with the StartValue as the first element and a function that returns the next number as the second element. 
    % We then call the function with the StartValue 0 and access the first element of the tuple to get the StartValue and the second element to get the function that returns the next number. 
    % We then call the function multiple times to get the next number in the sequence. 
    % The limitation of this solution is that it is not very efficient since it uses a lot of memory to store the function calls.
    % It is also not very practical since it is not easy to access the nth number in the sequence.
    % The function also does not handle negative numbers or floating-point numbers.

% Task 6
% a) Is your Sum function from Task 2 tail recursive? If yes, explain why. If not, implement a tail-recursive
% version and explain which changes you needed to introduce to make it tail recursive.


local Sum TailSum in
    fun {Sum List}
        {TailSum List 0}
    end

    fun {TailSum List Acc}
        case List
            of nil then Acc
            [] H|T then {TailSum T H+Acc}
        end
    end

    {System.show {Sum [1 2 3 4 5]}}
end
% Since my original function was only recursive, I had to change it to have an accumulator in a subfunction that is called with the initial function, but with an accumulator starting at 0.

% b) What is the benefit of tail recursion in Oz?
% The benefit of tail recursion in Oz is that it allows the compiler to optimize the code and avoid stack overflow errors by reusing the same stack frame for each recursive call.

% c) Do all programming languages that allow recursion benefit from tail recursion? Why/why not?

% No, not all programming languages that allow recursion benefit from tail recursion.
% Some languages do not optimize tail recursion and will still use the stack to store the function calls, which can lead to stack overflow errors.
% Other languages like Oz optimize tail recursion and reuse the same stack frame for each recursive call, which avoids stack overflow errors.