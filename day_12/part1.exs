rotate = %{
  "R" => %{
    "E" => ["E", "S", "W", "N"],
    "S" => ["S", "W", "N", "E"],
    "W" => ["W", "N", "E", "S"],
    "N" => ["N", "E", "S", "W"]
  },
  "L" => %{
    "E" => ["E", "N", "W", "S"],
    "N" => ["N", "W", "S", "E"],
    "W" => ["W", "S", "E", "N"],
    "S" => ["S", "E", "N", "W"]
  }
}

position =
  File.read!("input")
  |> String.split("\n")
  |> Enum.map(&String.split_at(&1, 1))
  |> Enum.map(fn {order, str} -> {order, String.to_integer(str)} end)
  |> Enum.reduce({"E", %{}}, fn {order, val}, {cur_dir, hash} ->
    case order do
      "F" ->
        {cur_dir, Map.update(hash, cur_dir, val, &(&1 + val))}

      dir when dir in ~w(N W S E) ->
        {cur_dir, Map.update(hash, dir, val, &(&1 + val))}

      rot when rot in ~w(L R) ->
        {rotate[rot][cur_dir] |> Enum.at(div(val, 90)), hash}
    end
  end)

{_, %{"E" => val_e, "W" => val_w, "N" => val_n, "S" => val_s}} = position

(abs(val_e - val_w) + abs(val_n - val_s))
|> IO.inspect()
