defmodule Lasagna do
  @moduledoc """
  A module dedicated to cooking a lasagna recipe.
  """

  @minutes_in_oven 40
  @minutes_per_layer 2

  @typedoc """
  Minutes associated with a timer.
  """
  @type minutes() :: Integer.t()

  @typedoc """
  Number of lasagna layers that will be used in a recipe.
  """
  @type layers() :: Integer.t()

  @doc """
  Returns the total cook time of lasagna, which is what `@minutes_in_oven` is set to.

  Examples ##
    iex> Lasagna.expected_minutes_in_oven()
    40
  """
  @spec expected_minutes_in_oven :: minutes()
  def expected_minutes_in_oven, do: @minutes_in_oven

  @doc """
  Accepts the number of `minutes` the lasagna has already been cooking for.
  Returns the number of `minutes` left in the oven until the lasagna is done.

  ## Examples
    iex> Lasagna.remaining_minutes_in_oven(5)
    35
  """
  @spec remaining_minutes_in_oven(time_in_oven :: minutes()) :: minutes()
  def remaining_minutes_in_oven(time_in_oven), do: expected_minutes_in_oven() - time_in_oven

  @doc """
  Accepts the number of lasagna `layers` that will be created during the recipe.
  Returns the number of `minutes` it takes to prep that many `layers`, using @minutes_per_layer.

  ## Examples
    iex> Lasagna.preparation_time_in_minutes(5)
    10
  """
  @spec preparation_time_in_minutes(layers :: layers()) :: minutes()
  def preparation_time_in_minutes(layers), do: layers * @minutes_per_layer

  @doc """
  Accepts the number of `layers` and that will be created and number of minutes `time_in_oven`
  the lasagna has been cooking so far.
  Returns the number of prep and cooking `minutes` spent in total.

  ## Examples
    iex> Lasagna.total_time_in_minutes(1, 30)
    32
  """
  @spec total_time_in_minutes(layers :: layers(), time_in_oven :: minutes()) :: minutes()
  def total_time_in_minutes(layers, time_in_oven),
    do: preparation_time_in_minutes(layers) + time_in_oven

  @doc """
  Returns a string to notify when the lasagna is done cooking.

  ## Examples
    iex> Lasagna.alarm
    "Ding!"
  """
  @spec alarm :: String.t()
  def alarm, do: "Ding!"
end
