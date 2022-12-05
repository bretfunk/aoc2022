defmodule AOC.DayFive do
  @testing true
  @test_file "day_5_test.txt"
  @real_file "day_5.txt"

  def file(), do: if(@testing, do: @test_file, else: @real_file)

  def problem_one() do
    IO.puts("Day 5, Problem 1")
    [stack, moves] = file() |> File.read!() |> String.split("\n\n", trim: true)

    moves = moves_to_tuple_instructions(moves)
    stack = [[] | stacks_to_list_of_lists(stack)]

    Enum.reduce(moves, stack, fn move, stack -> move(stack, move) end)
    |> Enum.map(&List.last/1)
    |> Enum.filter(fn s -> not is_nil(s) end)
    |> List.to_string()
  end

  def move(original_stack, {quantity, from, to} = move) do
    IO.inspect([original_stack, move], label: "move")
    from_col = Enum.at(original_stack, from)

    {to_move, new_from_col} = List.pop_at(from_col, -1)

    new_to_col = List.insert_at(Enum.at(original_stack, to), -1, to_move)

    new_stack =
      original_stack
      |> List.replace_at(from, new_from_col)
      |> List.replace_at(to, new_to_col)

    quantity = quantity - 1

    if quantity == 0 do
      IO.inspect(new_stack, label: "new stack")
      new_stack
    else
      move(new_stack, {quantity, from, to})
    end
  end

  def problem_two() do
    IO.puts("Day 5, Problem 1")
    "X"
  end

  # when is string

  def get_cols(string, index) do
    string
    |> Enum.map(fn s -> String.at(s, index) end)
    |> Enum.filter(fn s -> s != " " end)
    |> Enum.reverse()
  end

  def stacks_to_list_of_lists(string) do
    raw_cols =
      string
      |> String.split("\n", trim: true)
      |> Enum.take(3)

    [1, 5, 9]
    |> Enum.map(fn index -> get_cols(raw_cols, index) end)
  end

  # when is string
  def moves_to_tuple_instructions(raw_move) do
    raw_move
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ["from", "move", "to"], trim: true))
    |> Enum.map(fn move ->
      Enum.map(move, fn s -> s |> String.trim() |> String.to_integer() end)
      |> List.to_tuple()
    end)
  end

  def run(:one) do
    res = AOC.DayFive.problem_one()
    target = if @testing, do: "CMZ", else: ""
    IO.puts("#{res} - #{if res == target, do: "✅", else: "❌"}")
  end

  def run(:two) do
    res = AOC.DayFive.problem_two()
    target = if @testing, do: "", else: ""
    IO.puts("#{res} - #{if res == target, do: "✅", else: "❌"}")
  end
end

AOC.DayFive.run(:one)
AOC.DayFive.run(:two)
