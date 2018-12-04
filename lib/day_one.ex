defmodule DayOne do
  @moduledoc """
  This is definitely not the idiomatic way to solve the problem, but I'd already seen
  someone's solution (correctly) using `Enum.reduce_while`. So, I thought I'd mix it up
  and use an `Agent` for part two.
  """
  alias DayOne.PartTwo

  def part_one(input) do
    input
    |> to_int_list
    |> Enum.sum
  end

  def part_two(input) do
    {:ok, agent} = PartTwo.start_link()

    input
    |> to_int_list
    |> Stream.cycle
    |> Stream.map(&PartTwo.update(agent, &1))
    |> Stream.take_while(&(&1 == :ok))
    |> Stream.run

    PartTwo.get(agent)
  end

  def to_int_list(input) do
    input
    |> String.split
    |> Enum.map(&String.to_integer/1)
  end
end

defmodule DayOne.PartTwo do
  use Agent

  def start_link do
    Agent.start_link(fn -> [0] end)
  end

  def get(agent) do
    Agent.get(agent, &List.first(&1))
  end

  def update(agent, n) do
    Agent.get_and_update(agent, &calc(&1, n))
  end

  defp calc([freq | xs] = state, n) do
    if freq in xs do
      {:halt, state}
    else
      sum = freq + n
      {:ok, [sum | state]}
    end
  end
end
