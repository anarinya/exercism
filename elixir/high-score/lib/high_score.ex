defmodule HighScore do
  @score 0

  @spec new() :: map
  def new(), do: %{}

  @spec add_player(scores :: map, name :: String.t(), score :: integer) :: map
  def add_player(scores, name, score \\ @score), do: Map.put(scores, name, score)

  @spec remove_player(scores :: map, name :: String.t()) :: map
  def remove_player(scores, name), do: Map.delete(scores, name)

  @spec reset_score(scores :: map, name :: String.t()) :: map
  def reset_score(scores, name), do: Map.put(scores, name, @score)

  @spec update_score(scores :: map, name :: String.t(), score :: integer) :: map
  def update_score(scores, name, score \\ @score),
    do: Map.update(scores, name, score, &(&1 + score))

  @spec get_players(scores :: map) :: list(String.t())
  def get_players(scores), do: Map.keys(scores)
end
