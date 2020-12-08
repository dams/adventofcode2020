File.read!("input")
|> String.split("\n\n")
|> Enum.map(&String.split(&1, "\n"))
|> Enum.map(&Enum.join/1)
|> Enum.map(&String.graphemes/1)
|> Enum.map(&Enum.uniq/1)
|> Enum.map(&Enum.count/1)
|> Enum.sum()
|> IO.inspect()