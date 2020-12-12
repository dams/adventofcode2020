g = :digraph.new([:acyclic])

adapters =
  File.read!("input")
  |> String.split("\n")
  |> Enum.map(&String.to_integer/1)
  |> Enum.sort()

:digraph.add_vertex(g, 0, 1)

adapters
|> Enum.each(fn element ->
  :digraph.add_vertex(g, element, 0)
end)

[0 | adapters]
|> Enum.each(fn e ->
  {_, value} = :digraph.vertex(g, e)

  1..3
  |> Enum.each(fn delta ->
    case :digraph.vertex(g, e + delta) do
      {v, val} -> :digraph.add_vertex(g, v, val + value)
      false -> nil
    end
  end)
end)

{_, val} = :digraph.vertex(g, Enum.max(adapters))

val |> IO.inspect()
