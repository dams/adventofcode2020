defmodule T do
  def run(instructions, pos, acc, seen), do: run(instructions, pos, acc, seen, seen[pos])
  def run(_instructions, _pos, acc, _seen, 1), do: acc

  def run(instructions, pos, acc, seen, nil) do
    new_seen = Map.put(seen, pos, 1)
    {new_pos, new_acc} = eval_instruction(Enum.at(instructions, pos), pos, acc)
    run(instructions, new_pos, new_acc, new_seen)
  end

  def eval_instruction({"jmp", val}, pos, acc), do: {pos + val, acc}
  def eval_instruction({"acc", val}, pos, acc), do: {pos + 1, acc + val}
  def eval_instruction({"nop", _val}, pos, acc), do: {pos + 1, acc}
end

File.read!("input")
|> String.split("\n")
|> Enum.map(fn str ->
  [s1, s2] = String.split(str)
  {s1, String.to_integer(s2)}
end)
|> T.run(0, 0, %{})
|> IO.inspect()
