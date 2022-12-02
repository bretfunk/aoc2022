defmodule AOC.DayTwo do
  @moduledoc """
  *** PROBLEM ONE ***
  The winner of the whole tournament is the player with the highest score.
  Your total score is the sum of your scores for each round.
  The score for a single round is the score for the shape you selected
  (1 for Rock, 2 for Paper, and 3 for Scissors) plus the score for the outcome of the round
  (0 if you lost, 3 if the round was a draw, and 6 if you won).

  1 rock
  2 paper
  3 scissors

  *** PROBLEM TWO ***
  The winner of the whole tournament is the player with the highest score.
  The Elf finishes helping with the tent and sneaks back over to you. "Anyway, the second column says how the round needs to end: X means you need to lose, Y means you need to end the round in a draw, and Z means you need to win. Good luck!"

  The total score is still calculated in the same way, but now you need to figure out what shape to choose so the round ends as indicated. The example above now goes like this:

  In the first round, your opponent will choose Rock (A), and you need the round to end in a draw (Y), so you also choose Rock. This gives you a score of 1 + 3 = 4.
  In the second round, your opponent will choose Paper (B), and you choose Rock so you lose (X) with a score of 1 + 0 = 1.
  In the third round, you will defeat your opponent's Scissors with Rock for a score of 1 + 6 = 7.
  Now that you're correctly decrypting the ultra top secret strategy guide, you would get a total score of 12.
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
      |> convert_letter()
      |> win_or_lost?(convert_letter(you))
      |> score_calculator()
      |> Kernel.+(convert_letter(you))
      # need to make up for 0 indexing needed to mod in prob 2
      |> Kernel.+(1)
      |> Kernel.+(acc)
    end)
  end

  def problem_two do
    IO.puts("Day 2 problem 2")

    file()
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(" ")
    end)
    |> Enum.reduce(0, fn [opp, need_to_play], acc ->
      need_to_play
      |> convert_to_outcome()
      |> outcome_to_move(convert_letter(opp))
      |> Kernel.+(score_calculator(need_to_play))
      # need to make up for 0 indexing needed to mod in prob 2
      |> Kernel.+(1)
      |> Kernel.+(acc)
    end)
  end

  # problem two functions
  def convert_to_outcome("X"), do: :lose
  def convert_to_outcome("Y"), do: :draw
  def convert_to_outcome("Z"), do: :win

  def outcome_to_move(:win, num), do: num |> Kernel.+(1) |> Integer.mod(3)
  def outcome_to_move(:draw, num), do: num
  def outcome_to_move(:lose, num), do: num |> Kernel.-(1) |> Kernel.+(3) |> Integer.mod(3)

  # problem one functions
  def convert_letter("A"), do: 0
  def convert_letter("B"), do: 1
  def convert_letter("C"), do: 2
  def convert_letter("X"), do: 0
  def convert_letter("Y"), do: 1
  def convert_letter("Z"), do: 2

  def win_or_lost?(opponent, you) when opponent == you, do: :draw
  def win_or_lost?(0, 2), do: :lose
  def win_or_lost?(0, 1), do: :win
  def win_or_lost?(1, 0), do: :lose
  def win_or_lost?(1, 2), do: :win
  def win_or_lost?(2, 0), do: :win
  def win_or_lost?(2, 1), do: :lose

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

AOC.DayTwo.run(:two)
