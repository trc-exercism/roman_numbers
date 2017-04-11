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

    get_thousands(thousands) <>
    transform_into(hundreds,"C",%{rep9: "CM", rep5: "D", rep4: "CD"}) <>
    transform_into(decs,"X",%{rep9: "XC", rep5: "L", rep4: "XL"}) <>
    transform_into(units,"I",%{rep9: "IX", rep5: "V", rep4: "IV"})
  end
  
  def get_thousands(thousands), do: String.duplicate("M", thousands)
  
  def transform_into(unit, matching_condition, map_reps) do
    [to_match] = String.to_char_list(matching_condition)
    String.duplicate(matching_condition, unit)
    |> to_charlist
    |> check_repetitions(9, 0, to_match,map_reps[:rep9],[""])
    |> to_charlist
    |> check_repetitions(5, 0, to_match,map_reps[:rep5],[""])
    |> to_charlist
    |> check_repetitions(4, 0, to_match,map_reps[:rep4],[""])
  end
  
  # -------------------
  # ENDING CONDITIONS
  # -------------------
  # End of list
  def check_repetitions([] , repetitions, repetitions, _, substitute_by, _), do: substitute_by
  def check_repetitions([] , repetitions, _, _, _, list), do: List.to_string(list)
  # For partial matches
  def check_repetitions([h|t] , repetitions, repetitions, _, substitute_by, list), do: substitute_by <> List.to_string([h] ++ t)
  #
  
  # Match on the character I am looking for, "h"
  def check_repetitions([h|t] , repetitions, acc, h, substitute_by, original_list) do
    check_repetitions(t, repetitions, acc + 1, h, substitute_by, original_list ++ [h])
  end
  
  # No match on the character I am looking for, "h". Continue for a partial match
  def check_repetitions([h|t] , repetitions, acc, search_for, substitute_by, original_list) do
    check_repetitions(t, repetitions, acc, search_for, substitute_by, original_list ++ [h])
  end


end