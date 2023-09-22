defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string \\ "") when is_binary(string) do
    remove_symbols(string)
    |> split_on_space_or_dash
    |> get_first_letters
    |> Enum.map(&String.upcase/1)
    |> Enum.join("")
  end

  defp remove_symbols(str), do: String.replace(str, ~r/[^a-zA-Z\- ]/, "")
  defp split_on_space_or_dash(str), do: String.split(str, ~r/[ -]/, trim: true)
  defp get_first_letters(list), do: Enum.map(list, &String.at(&1, 0))
end
