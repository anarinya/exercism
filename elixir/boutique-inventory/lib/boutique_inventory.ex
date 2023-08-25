defmodule BoutiqueInventory do
  def sort_by_price(inventory), do: Enum.sort_by(inventory, & &1.price)

  def with_missing_price(inventory), do: Enum.filter(inventory, &(!&1.price))

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, &%{&1 | name: String.replace(&1.name, old_word, new_word)})
  end

  def increase_quantity(%{quantity_by_size: sizes} = item, count) do
    new_counts = Enum.flat_map(sizes, &%{elem(&1, 0) => elem(&1, 1) + count})
    %{item | quantity_by_size: Map.new(new_counts)}
  end

  def total_quantity(%{quantity_by_size: sizes}) do
    Enum.reduce(sizes, 0, &(&2 + elem(&1, 1)))
  end
end
