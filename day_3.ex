defmodule AOC.DayThree do
  @testing false
  @test_file "day_3_test.txt"
  @real_file "day_3.txt"

  def problem_one() do
    file = if(@testing, do: @test_file, else: @real_file)

    file
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [string_1, string_2] = split_in_half(line)

      find_duplicate(string_1, string_2)
    end)
    |> Enum.reduce(0, fn letter, acc ->
      letter_to_number(letter) + acc
    end)
    |> IO.inspect()
  end

  def split_in_half(string) do
    half_length =
      string
      |> String.length()
      |> Kernel.div(2)

    [String.slice(string, 0..(half_length - 1)), String.slice(string, (half_length * -1)..-1)]
  end

  def find_duplicate(string_1, string_2) do
    string_1
    |> String.codepoints()
    |> MapSet.new()
    |> MapSet.intersection(MapSet.new(String.codepoints(string_2)))
    |> Enum.into([])
    |> List.first()
  end

  def letter_to_number(letter) do
    if letter == String.upcase(letter) do
      <<subtracting_from>> = "A"
      <<letter>> = letter
      letter - subtracting_from + 27
    else
      <<subtracting_from>> = "a"
      <<letter>> = letter
      letter - subtracting_from + 1
    end
  end
end

AOC.DayThree.problem_one()
