{_, ones, threes} =
  File.read!("input")
  |> String.split("\n")
  |> Enum.map(&String.to_integer/1)
  |> Enum.sort()
  |> Enum.reduce({0, 0, 0}, fn e, {previous, ones, threes} ->
    case e - previous do
      1 -> {e, ones + 1, threes}
      3 -> {e, ones, threes + 1}
    end
  end)

(ones * (threes + 1))
|> IO.inspect()
