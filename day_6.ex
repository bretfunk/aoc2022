defmodule AOC.DaySix do
  @testing false
  @test_file "day_6_test.txt"
  @real_file "day_6.txt"

  def file(), do: if(@testing, do: @test_file, else: @real_file)

  def problem_one() do
    IO.inspect("Day 6, Problem 1")

    file()
    |> File.read!()
    |> then(fn string -> find_first_marker(%{}, string, 0, 4) end)
  end

  def problem_two() do
    IO.inspect("Day 6, Problem 2")

    file()
    |> File.read!()
    |> then(fn string -> find_first_marker(%{}, string, 0, 14) end)
  end

  def add_letter(letter_bank, letter_to_add) do
    letter_bank
    |> Map.update(letter_to_add, 1, &(&1 + 1))
  end

  def remove_letter(letter_bank, letter_to_remove) do
    letter_bank
    |> Map.update(letter_to_remove, 0, &(&1 - 1))
  end

  def delete_if_zero(letter_bank, letter) do
    if Map.get(letter_bank, letter) == 0 do
      Map.delete(letter_bank, letter)
    else
      letter_bank
    end
  end

  def check_for_distinct(letter_bank, message_length) do
    letter_bank
    |> Enum.count()
    |> Kernel.==(message_length)
  end

  def find_first_marker(letter_bank, string, index, message_length) do
    letter_bank = add_letter(letter_bank, String.at(string, index))

    if index < message_length do
      find_first_marker(letter_bank, string, index + 1, message_length)
    else
      letter_bank =
        letter_bank
        |> remove_letter(String.at(string, index - message_length))
        |> delete_if_zero(String.at(string, index - message_length))

      if check_for_distinct(letter_bank, message_length) do
        index + 1
      else
        find_first_marker(letter_bank, string, index + 1, message_length)
      end
    end
  end

  def run(:one) do
    res = AOC.DaySix.problem_one()
    target = if @testing, do: 7, else: 1651
    IO.puts("#{res} - #{if res == target, do: "✅", else: "❌"}")
  end

  def run(:two) do
    res = AOC.DaySix.problem_two()
    target = if @testing, do: 19, else: 3837
    IO.puts("#{res} - #{if res == target, do: "✅", else: "❌"}")
  end
end

AOC.DaySix.run(:one)
AOC.DaySix.run(:two)
