defmodule AOC.DayThree do
  @testing false
  @test_file "day_3_test.txt"
  @real_file "day_3.txt"

  def problem_one() do
    IO.puts("Day 3 - Problem 1")
    file = if(@testing, do: @test_file, else: @real_file)

    file
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> split_in_half()
      |> find_duplicates()
      |> List.first()
      |> letter_to_number()
    end)
    |> Enum.sum()
  end

  def problem_two() do
    IO.puts("Day 3 - Problem 2")
    file = if(@testing, do: @test_file, else: @real_file)

    file
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.chunk_every(3)
    |> Enum.map(&find_duplicates/1)
    |> Enum.map(fn dups ->
      dups
      |> List.first()
      |> letter_to_number()
    end)
    |> Enum.sum()
  end

  def split_in_half(string) do
    string
    |> String.length()
    |> Kernel.div(2)
    |> then(&String.split_at(string, &1))
    |> Tuple.to_list()
  end

  def find_duplicates(strings) when is_list(strings) do
    strings
    |> Enum.map(fn string ->
      string
      |> String.codepoints()
      |> MapSet.new()
    end)
    |> Enum.reduce(&MapSet.intersection(&1, &2))
    |> Enum.into([])
  end

  def letter_to_number(letter) do
    if letter == String.upcase(letter) do
      letter
      |> letter_to_ascii()
      |> Integer.mod(?A)
      |> Kernel.+(27)
    else
      letter
      |> letter_to_ascii()
      |> Integer.mod(?a)
      |> Kernel.+(1)
    end
  end

  def letter_to_ascii(letter) do
    <<letter>> = letter
    letter
  end

  def run(:one) do
    res = AOC.DayThree.problem_one()
    target = if @testing, do: 157, else: 7872
    IO.puts("#{res} - #{if res == target, do: "✅", else: "❌"}")
  end

  def run(:two) do
    res = AOC.DayThree.problem_two()
    target = if @testing, do: 70, else: 2497
    IO.puts("#{res} - #{if res == target, do: "✅", else: "❌"}")
  end
end

AOC.DayThree.run(:one)
AOC.DayThree.run(:two)
