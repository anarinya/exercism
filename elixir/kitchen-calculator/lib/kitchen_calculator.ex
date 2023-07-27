defmodule KitchenCalculator do
  @units %{
    milliliter: 1,
    cup: 240.0,
    fluid_ounce: 30.0,
    teaspoon: 5.0,
    tablespoon: 15.0
  }

  @spec get_volume(measurement :: {atom, number}) :: number
  def get_volume({_, volume}), do: volume

  @spec to_milliliter(measurement :: {atom, number}) :: {atom, float}
  def to_milliliter({:cup, volume}), do: unit_to_ml(:cup, volume)
  def to_milliliter({:fluid_ounce, volume}), do: unit_to_ml(:fluid_ounce, volume)
  def to_milliliter({:teaspoon, volume}), do: unit_to_ml(:teaspoon, volume)
  def to_milliliter({:tablespoon, volume}), do: unit_to_ml(:tablespoon, volume)
  def to_milliliter({:milliliter, volume}), do: unit_to_ml(:milliliter, volume)

  @spec from_milliliter(measurement :: {atom, number}, unit :: atom) :: {atom, float}
  def from_milliliter({:milliliter, volume}, :cup), do: ml_to_unit(:cup, volume)
  def from_milliliter({:milliliter, volume}, :fluid_ounce), do: ml_to_unit(:fluid_ounce, volume)
  def from_milliliter({:milliliter, volume}, :teaspoon), do: ml_to_unit(:teaspoon, volume)
  def from_milliliter({:milliliter, volume}, :tablespoon), do: ml_to_unit(:tablespoon, volume)
  def from_milliliter({:milliliter, volume}, :milliliter), do: ml_to_unit(:milliliter, volume)

  @spec convert(measurement :: {atom, number}, unit :: atom) :: {atom, float}
  def convert(measurement, unit), do: to_milliliter(measurement) |> from_milliliter(unit)

  defp unit_to_ml(unit, volume), do: {:milliliter, volume * @units[unit]}
  defp ml_to_unit(unit, volume), do: {unit, volume / @units[unit]}
end
