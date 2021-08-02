defmodule GenServer101Test do
  use ExUnit.Case
  doctest GenServer101

  test "greets the world" do
    assert GenServer101.hello() == :world
  end
end
