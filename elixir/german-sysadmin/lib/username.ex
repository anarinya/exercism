defmodule Username do
  @doc """
  The sanitize/1 function should replace all special characters in the username.
  """
  @spec sanitize(charlist()) :: charlist()
  def sanitize(username) do
    username
    |> Enum.flat_map(&convert_german_char/1)
    |> Enum.filter(&invalid_char?/1)
  end

  # Convert special german characters to their ASCII equivalent
  @spec convert_german_char(char()) :: char()
  defp convert_german_char(char) do
    case char do
      ?ä -> ~c"ae"
      ?ö -> ~c"oe"
      ?ü -> ~c"ue"
      ?ß -> ~c"ss"
      _ -> [char]
    end
  end

  # Return true if character is alpheneumeric or an underscore
  @spec invalid_char?(char()) :: boolean()
  defp invalid_char?(char) do
    case char do
      char when char in ?a..?z -> true
      ?_ -> true
      _ -> false
    end
  end
end
