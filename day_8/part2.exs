defmodule T do
  def run(instructions, pos, acc, _seen) when pos == length(instructions), do: acc
  def run(instructions, pos, acc, seen), do: run(instructions, pos, acc, seen, seen[pos])
  def run(_instructions, _pos, _acc, _seen, 1), do: nil

  def run(instructions, pos, acc, seen, nil) do
    new_seen = Map.put(seen, pos, 1)
    {new_pos, new_acc} = eval_instruction(Enum.at(instructions, pos), pos, acc)
    run(instructions, new_pos, new_acc, new_seen)
  end

  def eval_instruction({"jmp", val}, pos, acc), do: {pos + val, acc}
  def eval_instruction({"acc", val}, pos, acc), do: {pos + 1, acc + val}
  def eval_instruction({"nop", _val}, pos, acc), do: {pos + 1, acc}
end

swap = %{"jmp" => "nop", "nop" => "jmp", "acc" => "acc"}

instructions =
  File.read!("input")
  |> String.split("\n")
  |> Enum.map(fn str ->
    [s1, s2] = String.split(str)
    {s1, String.to_integer(s2)}
  end)

0..(length(instructions) - 1)
|> Enum.reduce_while(nil, fn pos, nil ->
  case List.update_at(instructions, pos, fn {inst, val} -> {swap[inst], val} end)
       |> T.run(0, 0, %{}) do
    nil -> {:cont, nil}
    acc -> {:halt, acc}
  end
end)
|> IO.inspect()
