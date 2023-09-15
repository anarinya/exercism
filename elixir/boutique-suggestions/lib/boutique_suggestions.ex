defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ []) do
    max_price = Keyword.get(options, :maximum_price, 100.00)

    for top <- tops,
        bottom <- bottoms,
        not clashing_outfits?(top, bottom),
        not too_expensive?(top, bottom, max_price) do
      {top, bottom}
    end
  end

  defp clashing_outfits?(top, bottom), do: top.base_color == bottom.base_color
  defp too_expensive?(top, bottom, max_price), do: top.price + bottom.price > max_price
end
