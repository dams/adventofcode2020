File.stream!("input")
|> Stream.filter(fn str ->
  [_, min, max, char, pass] = Regex.run(~r/^(\d+)-(\d+) (.): (\S+)/, str)
  count = String.graphemes(pass) |> Enum.frequencies() |> Map.get(char, 0)
  count >= String.to_integer(min) && count <= String.to_integer(max)
end)
|> Enum.count()
|> IO.puts()
