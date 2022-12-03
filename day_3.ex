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

      string_1
      |> find_duplicate(string_2)
      |> letter_to_number()
    end)
    |> Enum.sum()
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
    set_2 =
      string_2
      |> String.codepoints()
      |> MapSet.new()

    string_1
    |> String.codepoints()
    |> MapSet.new()
    |> MapSet.intersection(set_2)
    |> Enum.into([])
    |> List.first()
  end

  def letter_to_number(letter) do
    if letter == String.upcase(letter) do
      letter
      |> letter_to_ascii()
      |> Kernel.-(letter_to_ascii("A"))
      |> Kernel.+(27)
    else
      letter
      |> letter_to_ascii()
      |> Kernel.-(letter_to_ascii("a"))
      |> Kernel.+(1)
    end
  end

  def letter_to_ascii(letter) do
    <<letter>> = letter
    letter
  end
end

AOC.DayThree.problem_one()
