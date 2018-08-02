defmodule Challenge1 do
  def numeric_range(numbers) do
    enum_numbers = if is_tuple(numbers), do: Tuple.to_list(numbers), else: numbers
    enum_numbers
    |> Enum.min_max(fn -> {0, 0} end)
    |> Tuple.to_list
    |> Enum.reduce(fn x, y -> x - y end)
  end
end
