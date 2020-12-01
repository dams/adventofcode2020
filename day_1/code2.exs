l = File.read!("input") |> String.split("\n") |> Enum.map(&String.to_integer/1)

for i <- l,
    max = 2020 - i,
    j <- l,
    j <= max,
    max2 = max - j
    k <- l,
    k <= max2,
    i + j + k == 2020,
    do: (i * j * k) |> IO.inspect() |> System.halt()
