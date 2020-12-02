true_one = &if String.at(&1, String.to_integer(&2) - 1) == &3, do: 1, else: 0

File.stream!("input")
|> Enum.count(fn str ->
  [_, p1, p2, char, pass] = Regex.run(~r/^(\d+)-(\d+) (.): (\S+)/, str)
  true_one.(pass, p1, char) + true_one.(pass, p2, char) == 1
end)
|> IO.puts()
