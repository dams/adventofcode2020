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

:digraph_utils.reaching_neighbours(["shiny gold"], g)
|> Enum.count()
|> IO.inspect()
