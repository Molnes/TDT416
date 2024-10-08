declare Lex  Tokenize  Interpret TrueInterpret ExpressionTreeInternal ExpressionTree in

% Task 1
% a)
fun {Lex Input}
   {String.tokens Input 32}
end

{System.showInfo "Task 1a: "}
{Show {Lex "1 2 + 3 *"}}


% b)

fun {Tokenize Lexemes}
   case Lexemes of Head|Tail then 
        if {String.isFloat Head} then
           number(1:{String.toFloat Head}) 
        elseif {List.member Head ["+" "-" "/" "*"] } then 
           operator(type: case Head of "+" then "plus" 
                       [] "-" then "minus" 
                       [] "*" then "multiply" 
                       [] "/" then "divide" end) 
        elseif {List.member Head ["p" "c" "d" "i"]} then
           command(type: case Head of "p" then "print" 
                   [] "i" then "inverse" 
                   [] "c" then "clear" 
                   [] "d" then "duplicate" end)
        end
        | {Tokenize Tail}
   else 
       nil
   end
end

{System.showInfo "Task 1b: "}
{Show {Tokenize {Lex "1 2 + 3 *"}}}


% c)
fun {Interpret Tokens}
   {TrueInterpret Tokens nil}
end

fun {TrueInterpret Tokens Stack}
   case Tokens of operator(type:C)|Rest then
       case Stack of N1|N2|Tail then
           if C == "plus" then
               {TrueInterpret Rest (N1+N2 | Tail)}
           elseif C == "minus" then
               {TrueInterpret Rest (N1-N2 | Tail)}
           elseif C == "divide" then
               {TrueInterpret Rest (N1/N2 | Tail)}
           elseif C == "multiply" then
               {TrueInterpret Rest (N1*N2 | Tail)}
           end
       end
   [] number(N)|Tail then
       {TrueInterpret Tail (N | Stack)}
   [] command(type:Action)|Tail then
       if Action == "print" then
           {Show Stack}
           {TrueInterpret Tail Stack}
       elseif Action == "duplicate" then
           {TrueInterpret Tail (Stack.1 | Stack)}
       elseif Action == "inverse" then
           case Stack of Head|Rest then
               {TrueInterpret Tail (~Head | Rest)}
           end
       elseif Action == "clear" then
           {TrueInterpret Tail nil}
       end
   else
       Stack
   end
end


{System.showInfo "Task 1c: "}
{Show {Interpret {Tokenize {Lex "1 2 3 +"}}}}



% d)

{System.showInfo "Task 1d: "}
{Show {Interpret {Tokenize {Lex "1 2 p 3 +"}}}}


% e)

{System.showInfo "Task 1e: "}
{Show {Interpret {Tokenize {Lex "1 2 3 + d"}}}}

% f)

{System.showInfo "Task 1f: "}
{Show {Interpret {Tokenize {Lex "1 2 3 + i"}}}}

% g)

{System.showInfo "Task 1g: "}
{Show {Interpret {Tokenize {Lex "1 2 3 + c"}}}}

% Task 2
% a)
fun {ExpressionTreeInternal Tokens ExpressionStack} NewExpr in
   case Tokens of operator(type:Op)|Rest then
      case ExpressionStack of E1|E2|Tail then
         NewExpr = case Op of
                      "plus" then plus(E1 E2)
                   [] "minus" then minus(E1 E2)
                   [] "multiply" then multiply(E1 E2)
                   [] "divide" then divide(E1 E2)
                   end
         {ExpressionTreeInternal Rest (NewExpr | Tail)}
      end
   [] number(N)|Rest then
      {ExpressionTreeInternal Rest (N | ExpressionStack)}
   else
      ExpressionStack.1
   end
end

{System.showInfo "Task 2a: "}
{Show {ExpressionTreeInternal {Tokenize {Lex "2 3 + 5 /"}} nil}}

% b)

fun {ExpressionTree Tokens}
   {ExpressionTreeInternal Tokens nil}
end

{System.showInfo "Task 2b: "}
{Show {ExpressionTree {Tokenize {Lex "3 10 9 * - 7 +"}}}}