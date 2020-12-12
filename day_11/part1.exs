world =
  File.read!("input")
  |> String.split("\n")
  |> Enum.map(&String.graphemes/1)
  |> Enum.map(fn lines ->
    Enum.map(lines, fn
      "L" -> 0
      "." -> nil
      "#" -> 1
    end)
  end)

defmodule T do
  def get_at(_world, -1, _y), do: nil
  def get_at(_world, _x, -1), do: nil
  def get_at(world, x, y), do: world |> Enum.at(y, []) |> Enum.at(x)

  def get_at_val(world, x, y), do: get_at_val(get_at(world, x, y))
  def get_at_val(nil), do: 0
  def get_at_val(val), do: val

  def update_at(world, x, y, callback) do
    List.update_at(world, y, fn line ->
      List.update_at(line, x, &callback.(&1))
    end)
  end

  def max_x_i([first_line | _]), do: length(first_line) - 1
  def max_y_i(world), do: length(world) - 1

  def run(world),
    do: run(world, world, max_x_i(world), max_y_i(world))

  def run(world, new_world, -1, -1) do
    if world == new_world do
      world |> Enum.map(fn l -> Enum.map(l, &get_at_val/1) |> Enum.sum() end) |> Enum.sum()
    else
      run(new_world)
    end
  end

  def run(world, new_world, -1, y), do: run(world, new_world, max_x_i(world), y - 1)

  def run(world, new_world, x, y), do: run(world, new_world, x, y, get_at(world, x, y))

  def run(world, new_world, x, y, nil), do: run(world, new_world, x - 1, y)

  def run(world, new_world, x, y, val) do
    around_pos = for a <- [x - 1, x, x + 1], b <- [y - 1, y, y + 1], {a, b} != {x, y}, do: {a, b}
    sum_around = around_pos |> Enum.map(fn {x, y} -> get_at_val(world, x, y) end) |> Enum.sum()

    new_val =
      cond do
        val == 0 && sum_around == 0 -> 1
        val == 1 && sum_around >= 4 -> 0
        true -> val
      end

    new_world = new_world |> update_at(x, y, fn _ -> new_val end)

    run(world, new_world, x - 1, y)
  end
end

T.run(world) |> IO.inspect()
