defmodule LanguageList do
  # Returns a new list
  @spec new() :: list
  def new(), do: []

  # Returns a new list with a given language added
  @spec add(list :: list, language :: String.t()) :: list
  def add(list, language), do: [language | list]

  # Returns a given list with the first element removed
  @spec remove(list :: list) :: list
  def remove(list), do: tl(list)

  # Returns the first element of a given list
  @spec first(list :: list) :: String.t()
  def first(list), do: hd(list)

  # Returns the number of elements in a given list
  @spec count(list :: list) :: non_neg_integer
  def count(list), do: length(list)

  # Returns true if "Elixir" is present in a given list
  @spec functional_list?(list :: list) :: boolean
  def functional_list?(list), do: "Elixir" in list
end
