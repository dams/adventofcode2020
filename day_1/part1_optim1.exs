l = File.read!("input") |> String.split("\n") |> Enum.map(&String.to_integer/1)

{l1, l2} = l |> Enum.split_with(&(&1 < 1010))
for i <- l1, j <- l2, i + j == 2020, do: (i * j) |> IO.inspect() |> System.halt()
