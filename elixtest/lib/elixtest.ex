defmodule Elixtest do
  @moduledoc """
  Documentation for `Elixtest`.
  """
"""
  ## Examples

      iex> Elixtest.lex("1 2 +")
      ["1", "2" "+"]
  """
  @spec lex(binary()) :: [binary()]
  def lex(input) do
    input
    |> String.split(~r/\s+/)
  end

  """
  ## Examples

      iex> Elixtest.tokenize(["1" "+" "2"])
      [{:int, 1}, {:int, 2}, {:op, :+}]
  """
  def tokenize([]), do: []

  def tokenize([head | tail]) do
    case head do
      "+" -> [{:op, :+} | tokenize(tail)]
      "-" -> [{:op, :-} | tokenize(tail)]
      "*" -> [{:op, :*} | tokenize(tail)]
      "/" -> [{:op, :/} | tokenize(tail)]
      _ -> [{:int, String.to_integer(head)} | tokenize(tail)]
    end
  end







"""
  Interpret according to mdc

  eg. ["1", "2", "+"] => 3
      ["1", "2", "+", "3", "*"] => 9

      if the input is ["1", "2", "+", "3", "*"], the output should be 9
      since 1 is added to the stack, then 2 is added to the stack, then 1 and 2 are popped from the stack and added together, then 3 is added to the stack, then 3 is multiplied by the result of 1 + 2, which is 3, so the result is 9

"""
@spec interpret([{:int, integer()} | {:op, :* | :+ | :- | :/}]) :: integer()
def interpret([]), do: 0

def interpret(tokens) do
  interpret(tokens, [])
end

defp interpret([], [result]), do: result

defp interpret([{:int, n} | tail], stack) do
  interpret(tail, [n | stack])
end

defp interpret([{:op, :+} | tail], [a, b | stack]) do
  interpret(tail, [a + b | stack])
end

defp interpret([{:op, :-} | tail], [a, b | stack]) do
  interpret(tail, [a - b | stack])
end

defp interpret([{:op, :*} | tail], [a, b | stack]) do
  interpret(tail, [a * b | stack])
end

defp interpret([{:op, :/} | tail], [a, b | stack]) do
  interpret(tail, [a / b | stack])
end


def run do
  lexed = lex("1 2 + 3 *")
  IO.inspect(lexed)
  tokens = tokenize(lexed)
  IO.inspect(tokens)
  result = interpret(tokens)
  IO.inspect(result)
end




end
