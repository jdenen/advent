defmodule DayTwo do
  alias DayTwo.PartOne
  alias DayTwo.PartTwo

  def part_one(input) do
    {:ok, pid} = PartOne.start_link()

    input
    |> codepoints_by_line
    |> Enum.map(&reduce_to_char_counts/1)
    |> Enum.flat_map(&unique_values/1)
    |> Enum.each(&PartOne.update(pid, &1))

    pid
    |> PartOne.get
    |> Enum.reduce(1, &(&1 * &2))
  end

  def part_two(input) do
    {:ok, pid} = PartTwo.start_link()

    input
    |> codepoints_by_line
    |> Stream.map(&PartTwo.scan(pid, &1))
    |> Enum.take_while(&(&1 == :cont))

    PartTwo.get(pid)
    |> list_common_letters
    |> Enum.join
  end

  defp codepoints_by_line(string) do
    string
    |> String.split
    |> Enum.map(&String.codepoints/1)
  end

  defp list_common_letters([a, b]) do
    List.myers_difference(a, b)
    |> Enum.reduce([], fn
      {:eq, val}, acc -> acc ++ val
      _, acc  -> acc
    end)
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

defmodule DayTwo.PartTwo do
  use Agent

  def start_link do
    Agent.start_link(fn -> [] end)
  end

  def get(pid) do
    Agent.get(pid, fn state -> state end)
  end

  def scan(pid, id) do
    Agent.get_and_update(pid, &find_pair_for(id, &1))
  end

  defp find_pair_for(id, []), do: {:cont, [id]}
  defp find_pair_for(id, state) do
    with [pair] <- Enum.filter(state, &has_pair?(&1, id)) do
      {:halt, [id, pair]}
    else
      _ -> {:cont, [id | state]}
    end
  end

  defp has_pair?(a, b) do
    List.myers_difference(a, b)
    |> Enum.reduce([], fn
      {:del, val}, acc -> acc ++ val
      _, acc -> acc
    end)
    |> Enum.count == 1
  end
end
