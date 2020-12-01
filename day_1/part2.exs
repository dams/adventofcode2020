l = File.read!("input") |> String.split("\n") |> Enum.map(&String.to_integer/1)

for i <- l, j <- l, k <- l, i + j + k == 2020, do: (i * j * k) |> IO.inspect() |> System.halt()
