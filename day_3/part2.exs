defmodule Part2 do
  def run(stream, delta_x, delta_y) do
    stream
    |> Stream.take_every(delta_y)
    |> Enum.reduce({0, 0}, fn line, {x, count} ->
      count =
        case String.at(line, x) do
          "#" -> count + 1
          _ -> count
        end

      x = x + delta_x
      x = if x >= String.length(line), do: x - String.length(line), else: x
      {x, count}
    end)
    |> elem(1)
  end
end

stream = File.stream!("input") |> Stream.map(&String.trim/1)

[{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]
|> Enum.map(fn {delta_x, delta_y} -> Part2.run(stream, delta_x, delta_y) end)
|> Enum.reduce(&(&1 * &2))
|> IO.inspect()
