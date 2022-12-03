defmodule AOC.DayTwo do
  @moduledoc """
  https://adventofcode.com/2022/day/2
  """

  @testing false
  @test_file "day_2_test.txt"
  @real_file "day_2.txt"

  def file(), do: if(@testing, do: @test_file, else: @real_file)

  def problem_one do
    IO.puts("Day 2 - Problem 1")

    file()
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(" ")
    end)
    |> Enum.reduce(0, fn [opp, you], acc ->
      opp
      |> letter_to_number()
      |> outcome(letter_to_number(you))
      |> score_calculator()
      |> Kernel.+(letter_to_number(you))
      # need to make up for 0 indexing needed to mod in prob 2
      |> Kernel.+(1)
      |> Kernel.+(acc)
    end)
  end

  def problem_two do
    IO.puts("Day 2 - Problem 2")

    file()
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(" ")
    end)
    |> Enum.reduce(0, fn [opp, need_to_play], acc ->
      need_to_play
      |> letter_to_outcome()
      |> outcome_to_move(letter_to_number(opp))
      |> Kernel.+(score_calculator(need_to_play))
      # need to make up for 0 indexing needed to mod in prob 2
      |> Kernel.+(1)
      |> Kernel.+(acc)
    end)
  end

  # problem two functions
  def letter_to_outcome("X"), do: :lose
  def letter_to_outcome("Y"), do: :draw
  def letter_to_outcome("Z"), do: :win

  def outcome_to_move(:win, num), do: num |> Kernel.+(1) |> Integer.mod(3)
  def outcome_to_move(:draw, num), do: num
  def outcome_to_move(:lose, num), do: num |> Kernel.-(1) |> Kernel.+(3) |> Integer.mod(3)

  # problem one functions
  def letter_to_number("A"), do: 0
  def letter_to_number("B"), do: 1
  def letter_to_number("C"), do: 2
  def letter_to_number("X"), do: 0
  def letter_to_number("Y"), do: 1
  def letter_to_number("Z"), do: 2

  def outcome(x, x), do: :draw
  def outcome(0, 2), do: :lose
  def outcome(0, 1), do: :win
  def outcome(1, 0), do: :lose
  def outcome(1, 2), do: :win
  def outcome(2, 0), do: :win
  def outcome(2, 1), do: :lose

  def score_calculator(:win), do: 6
  def score_calculator(:draw), do: 3
  def score_calculator(:lose), do: 0
  def score_calculator("Z"), do: 6
  def score_calculator("Y"), do: 3
  def score_calculator("X"), do: 0

  def run(:one) do
    res = AOC.DayTwo.problem_one()
    target = if @testing, do: 15, else: 15337
    IO.puts("#{res} - #{if res == target, do: "✅", else: "❌"}")
  end

  def run(:two) do
    res = AOC.DayTwo.problem_two()
    target = if @testing, do: 12, else: 11696
    IO.puts("#{res} - #{if res == target, do: "✅", else: "❌"}")
  end
end

AOC.DayTwo.run(:one)
AOC.DayTwo.run(:two)
