g = :digraph.new([:acyclic])

File.read!("input")
|> String.split("\n")
|> Enum.each(fn str ->
  #  str |> IO.inspect(label: "STR")
  [_, orig, dests_str] = Regex.run(~r/^(.+) bags contain (.+).$/, str)
  :digraph.add_vertex(g, orig)

  if dests_str != "no other bags" do
    String.split(dests_str, ", ")
    |> Enum.each(fn dest_str ->
      [_, quantity, dest] = Regex.run(~r/^(\d+) (.+) bags?$/, dest_str)
      :digraph.add_vertex(g, dest)
      :digraph.add_edge(g, orig, dest, String.to_integer(quantity))
    end)
  end
end)

defmodule T do
  def recurse(_g, [], count), do: count

  def recurse(g, [{vertex, factor} | vertices], count) do
    {new_vertices, new_count} =
      :digraph.out_edges(g, vertex)
      |> Enum.reduce({vertices, count}, fn edge, {vertices, count} ->
        case :digraph.edge(g, edge) do
          false ->
            {vertices, count}

          {^edge, ^vertex, v2, edge_count} ->
            {[{v2, edge_count * factor} | vertices], count + edge_count * factor}
        end
      end)

    recurse(g, new_vertices, new_count)
  end
end

T.recurse(g, [{"shiny gold", 1}], 0)
|> IO.inspect()

# Enum.reduce({, 0}, fn {vertex, count} ->
#   edges = :digraph.out_edges(g, vertex)

# end)

# :digraph_utils.reaching_neighbours(["shiny gold"], g)
# |> Enum.count()
# |> IO.inspect()
