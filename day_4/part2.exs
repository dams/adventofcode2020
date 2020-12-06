defmodule Part2 do
  def valid?({field, year}) when field in ["byr", "eyr", "iyr"] and is_binary(year),
    do: valid?({field, String.to_integer(year)})

  def valid?({"byr", year}) when year in 1920..2002, do: true
  def valid?({"iyr", year}) when year in 2010..2020, do: true
  def valid?({"eyr", year}) when year in 2020..2030, do: true

  def valid?({"hgt", {cm, "cm"}}) when cm in 150..193, do: true
  def valid?({"hgt", {inch, "in"}}) when inch in 59..76, do: true
  def valid?({"hgt", {_, _}}), do: false
  def valid?({"hgt", height}), do: valid?({"hgt", Integer.parse(height)})

  def valid?({"hcl", color}), do: Regex.match?(~r/^#[0-9a-f]{6}$/, color)

  def valid?({"ecl", color}) when color in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"],
    do: true

  def valid?({"pid", pid}), do: Regex.match?(~r/^[0-9]{9}$/, pid)
  def valid?({"cid", _}), do: true
  def valid?(_), do: false
end

File.read!("input")
|> String.split("\n\n")
|> Enum.map(fn str ->
  l =
    String.split(str)
    |> Enum.map(&(String.split(&1, ":") |> List.to_tuple()))

  l
  |> Enum.reject(fn {k, _} -> k == "cid" end)
  |> Enum.into(%{})
  |> Map.keys()
  |> Enum.join("") == "byrecleyrhclhgtiyrpid" &&
    l |> Enum.all?(&Part2.valid?/1)
end)
|> Enum.count(&(&1 == true))
|> IO.inspect()
