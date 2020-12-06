File.read!("input")
|> String.split("\n\n")
|> Enum.map(fn str ->
  String.split(str)
  |> Enum.reject(&(&1 =~ ~r/cid:/))
  |> Enum.sort()
  |> Enum.map(&(String.split_at(&1, 4) |> elem(0)))
  |> Enum.join("")
end)
|> Enum.count(&(&1 == "byr:ecl:eyr:hcl:hgt:iyr:pid:"))
|> IO.inspect()
