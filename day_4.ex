defmodule AOC.DayFour do
  @testing true
  @test_file "day_4_test.txt"
  @real_file "day_4.txt"

  def file(), do: if(@testing, do: @test_file, else: @real_file)

  def problem_one() do
    IO.puts("Day 4, Problem 1")

    file()
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(fn [one, two] -> [range_to_nums(one), range_to_nums(two)] end)
    |> Enum.filter(&complete_overlap?/1)
    |> Enum.count()
  end

  def problem_two() do
    IO.puts("Day 4, Problem 2")

    file()
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(fn [one, two] -> [range_to_nums(one), range_to_nums(two)] end)
    |> Enum.filter(&partial_overlap?/1)
    |> Enum.count()
  end

  def partial_overlap?([{range_1_start, range_1_end}, {range_2_start, range_2_end}]) do
    cond do
      range_1_end >= range_2_start and range_1_end <= range_2_end -> true
      range_2_end >= range_1_start and range_2_end <= range_1_end -> true
      true -> false
    end
  end

  def complete_overlap?([{range_1_start, range_1_end}, {range_2_start, range_2_end}]) do
    cond do
      range_1_start <= range_2_start and range_1_end >= range_2_end -> true
      range_2_start <= range_1_start and range_2_end >= range_1_end -> true
      true -> false
    end
  end

  def range_to_nums(range) do
    range
    |> String.split("-")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  def run(:one) do
    res = AOC.DayFour.problem_one()
    target = if @testing, do: 2, else: 569
    IO.puts("#{res} - #{if res == target, do: "✅", else: "❌"}")
  end

  def run(:two) do
    res = AOC.DayFour.problem_two()
    target = if @testing, do: 4, else: 936
    IO.puts("#{res} - #{if res == target, do: "✅", else: "❌"}")
  end
end

AOC.DayFour.run(:one)
AOC.DayFour.run(:two)
