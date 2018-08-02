ExUnit.start()

defmodule Challenge1Test do
  use ExUnit.Case

  require Integer
  require IEx.Helpers

  IEx.Helpers.import_file "./challenge_1.ex"

  # See https://stackoverflow.com/questions/32024156/how-do-i-raise-a-number-to-a-power-in-elixir
  def pow(_, 0), do: 1
  def pow(x, n) when Integer.is_odd(n), do: x * pow(x, n - 1)
  def pow(x, n) do
    result = pow(x, div(n, 2))
    result * result
  end

  test "ordered numbers" do
    result = [0, 1, 2, 3, 4]
    |> Challenge1.numeric_range
    assert result === 4
  end

  test "out of order numbers" do
    result = [10, 8, 7, 5.0, 3, 6, 2]
    |> Challenge1.numeric_range
    assert result === 8
  end

  test "single item" do
    result = [10]
    |> Challenge1.numeric_range
    assert result === 0
  end

  test "same item multiple times" do
    result = [8, 8, 8]
    |> Challenge1.numeric_range
    assert result === 0

    result = [7, 5, 6, 5, 7]
    |> Challenge1.numeric_range
    assert result === 2
  end

  test "negative_numbers" do
    result = [-10, -8, -7, -5, -3]
    |> Challenge1.numeric_range
    assert result === 7
  end

  test "mixed_types" do
    assert_raise ArithmeticError, fn ->
      ['a', 2]
      |> Challenge1.numeric_range
    end
  end

  test "very_large_numbers" do
    result = pow(2,1000)..(-pow(2,1000))
    |> Challenge1.numeric_range
    assert result === pow(2,1001)
  end

  test "returns zero for empty list" do
    result = []
    |> Challenge1.numeric_range
    assert result === 0
  end

  test "with non lists" do
    result = [89, 17, 70, 9]
    |> List.to_tuple
    |> Challenge1.numeric_range
    assert result === 80

    result = [8, 7, 5, 3, 9, 6, 2]
    |> MapSet.new
    |> Challenge1.numeric_range
    assert result === 7

    result = 1..3
    |> Enum.map(fn x -> pow(x, 2) end)
    |> Challenge1.numeric_range
    assert result === 8

    result = []
    |> Enum.map(fn x -> x end)
    |> Challenge1.numeric_range
    assert result === 0
  end

  test "massively long list" do
    result = 0..pow(10,9)
    |> Challenge1.numeric_range
    assert result === pow(10, 9)
  end

end
