l = File.read!("input") |> String.split("\n") |> Enum.map(&String.to_integer/1)

for i <- l, j <- l, i + j == 2020, do: (i * j) |> IO.inspect() |> System.halt()
