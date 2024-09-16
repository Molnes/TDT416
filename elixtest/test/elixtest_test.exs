defmodule ElixtestTest do
  use ExUnit.Case
  doctest Elixtest

  test "greets the world" do
    assert Elixtest.hello() == :world
  end
end
