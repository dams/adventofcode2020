defmodule T do
  def bis([], x, x), do: x
  def bis([x | tail], l, r) when x in ["F", "L"], do: bis(tail, l, l + div(r - l, 2))
  def bis([x | tail], l, r) when x in ["B", "R"], do: bis(tail, l + div(r - l, 2) + 1, r)
end

((File.read!("input")
  |> String.split("\n")
  |> Enum.map(&String.graphemes/1)
  |> Enum.map(&Enum.split(&1, 7))
  |> Enum.map(fn {rows, columns} ->
    T.bis(rows, 0, 127) * 8 + T.bis(columns, 0, 7)
  end)
  |> Enum.sort()
  |> Enum.reduce(fn
    e, acc when e == acc + 1 -> e
    _, acc -> acc
  end)) + 1)
|> IO.inspect()
