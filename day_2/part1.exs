File.stream!("input")
|> Enum.count(fn str ->
  [_, min, max, char, pass] = Regex.run(~r/^(\d+)-(\d+) (.): (\S+)/, str)

  String.graphemes(pass)
  |> Enum.count(&(&1 == char))
  |> Kernel.in(String.to_integer(min)..String.to_integer(max))
end)
|> IO.puts()
