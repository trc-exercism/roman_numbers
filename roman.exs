defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(number) do
    thousands = div(number, 1000)
    hundreds = div((number  - 1000*thousands),100)
    decs = div((number - 1000*thousands - 100*hundreds), 10)
    units = number - 1000*thousands - 100*hundreds - 10*decs
    get_thousands(thousands) <> get_hundreds(hundreds) <> get_desc(decs) <> get_units(units)
  end
  
  def get_thousands(thousands), do: String.duplicate("M", thousands)
  
  def get_hundreds(hundreds) do
    String.duplicate("C", hundreds)
    |> to_charlist
    |> check_repetitions(9,0,?C,"CM",[""])
    |> to_charlist
    |> check_repetitions(5,0,?C,"D",[""])
    |> to_charlist
    |> check_repetitions(4,0,?C,"CD",[""])
  end
  
  def get_desc(decs) do
    String.duplicate("X", decs)
    |> to_charlist
    |> check_repetitions(9,0,?X,"XC",[""])
    |> to_charlist
    |> check_repetitions(5,0,?X,"L",[""])
    |> to_charlist
    |> check_repetitions(4,0,?X,"XL",[""])
  end
  
  def get_units(units) do
    String.duplicate("I", units)
    |> to_charlist
    |> check_repetitions(9,0,?I,"IX",[""])
    |> to_charlist
    |> check_repetitions(5,0,?I,"V",[""])
    |> to_charlist
    |> check_repetitions(4,0,?I,"IV",[""])
  end
  
  def check_repetitions([] , repetitions, repetitions, _, substitute_by, _), do: substitute_by
  def check_repetitions([] , repetitions, _, _, _, list), do: List.to_string(list)
  def check_repetitions([h|t] , repetitions, repetitions, _, substitute_by, list), do: substitute_by <> List.to_string([h] ++ t)
  def check_repetitions([h|t] , repetitions, acc, h, substitute_by, original_list) do
    check_repetitions(t, repetitions, acc + 1, h, substitute_by, original_list ++ [h])
  end
  def check_repetitions([h|t] , repetitions, acc, search_for, substitute_by, original_list) do
    check_repetitions(t, repetitions, acc, search_for, substitute_by, original_list ++ [h])
  end


end