defmodule T do
  def run(_window, [], _tree), do: nil

  def run([window_head | window_tail], [number | rest], tree) do
    iterator = :gb_trees.iterator_from(div(number, 2), tree)

    case iterate(number, tree, :gb_trees.next(iterator)) do
      :no_pair_found ->
        number

      :found_pair ->
        tree = :gb_trees.delete(window_head, tree)
        tree = :gb_trees.insert(number, nil, tree)
        run(window_tail ++ [number], rest, tree)
    end
  end

  def iterate(_number, _tree, :none), do: :no_pair_found
  def iterate(number, _tree, {key1, _, _}) when key1 > number, do: :no_pair_found

  def iterate(number, tree, {key1, _, new_iterator}) do
    if number - key1 != key1 && :gb_trees.is_defined(number - key1, tree) do
      :found_pair
    else
      iterate(number, tree, :gb_trees.next(new_iterator))
    end
  end
end

tree = :gb_trees.empty()

{init, rest} =
  File.read!("input")
  |> String.split("\n")
  |> Enum.map(&String.to_integer/1)
  |> Enum.split(25)

tree =
  init
  |> Enum.reduce(tree, &:gb_trees.insert(&1, nil, &2))

T.run(init, rest, tree)
|> IO.inspect()
