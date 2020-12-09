defmodule T do
  def run(numbers, start_index, length, goal) do
    slice = Enum.slice(numbers, start_index, length)

    cond do
      Enum.sum(slice) == goal -> Enum.min(slice) + Enum.max(slice)
      Enum.sum(slice) > goal -> run(numbers, start_index + 1, 1, goal)
      true -> run(numbers, start_index, length + 1, goal)
    end
  end
end

numbers =
  File.read!("input")
  |> String.split("\n")
  |> Enum.map(&String.to_integer/1)

T.run(numbers, 0, 1, 14_144_619)
|> IO.inspect()
