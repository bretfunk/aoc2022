# Part 1

# "day_1.txt"
# "day_1_test.txt"
# |> File.read!()
# |> String.split("\n\n")
# |> Enum.map(fn line ->
#   line
#   |> String.split("\n", trim: true)
#   |> Enum.reduce(0, fn group, acc ->
#     group
#     |> String.replace("\n", "")
#     |> String.to_integer()
#     |> Kernel.+(acc)
#   end)
# end)
# |> Enum.max()
# |> IO.inspect()

# Part 2

"day_1.txt"
# "day_1_test.txt"
|> File.read!()
|> String.split("\n\n")
|> Enum.map(fn line ->
  line
  |> String.split("\n", trim: true)
  |> Enum.reduce(0, fn group, acc ->
    group
    |> String.replace("\n", "")
    |> String.to_integer()
    |> Kernel.+(acc)
  end)
end)
|> Enum.sort()
|> Enum.slice(-3..-1)
|> Enum.reduce(0, fn group, acc ->
  group
  |> Kernel.+(acc)
end)
|> IO.inspect()
