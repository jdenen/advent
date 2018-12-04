defmodule DayTwo do
  alias DayTwo.PartOne

  def part_one(input) do
    {:ok, pid} = PartOne.start_link()

    input
    |> String.split
    |> Enum.map(&String.codepoints/1)
    |> Enum.map(&reduce_to_char_counts/1)
    |> Enum.flat_map(&unique_values/1)
    |> Enum.each(&PartOne.update(pid, &1))

    pid
    |> PartOne.get
    |> Enum.reduce(1, &(&1 * &2))
  end

  defp reduce_to_char_counts(chars) do
    chars
    |> Enum.reduce(%{}, &Map.update(&2, &1, 1, fn v -> v + 1 end))
  end

  defp unique_values(map) do
    map
    |> Map.values
    |> Enum.uniq
  end
end

defmodule DayTwo.PartOne do
  use Agent

  def start_link do
    Agent.start_link(fn -> %{} end)
  end

  def get(pid) do
    Agent.get(pid, &Map.values(&1))
  end

  def update(pid, 2), do: increment(pid, :two)
  def update(pid, 3), do: increment(pid, :three)
  def update(_, _), do: :ok

  defp increment(pid, key) do
    Agent.update(pid, &Map.update(&1, key, 1, fn n -> n + 1 end))
  end
end
