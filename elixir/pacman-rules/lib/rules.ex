defmodule Rules do
  @moduledoc """
  Pacman ruleset logic.

  A power pellet grants pacman the ability to overpower ghosts.
  If pacman touches a ghost, he dies unless he has a power pellet.

  The `power_pellet_active?` boolean is true when pacman touches a power pellet.
  The `touching_ghost?` boolean is active when pacman touches a ghost.
  """

  @doc """
  Pacman can only successfully eat a ghost if he has the power pellet and he touches one.
  Otherwise, he doesn't succeed in eating a ghost.
  """
  @spec eat_ghost?(power_pellet_active? :: boolean, touching_ghost? :: boolean) :: boolean
  def eat_ghost?(true, true), do: true
  def eat_ghost?(_, _), do: false

  @doc """
  Pacman doesn't score if he doesn't touch a power pellet or a dot.
  However, if he touches a power pellet or a dot, he does score.
  """
  @spec score?(touching_power_pellet? :: boolean, touching_dot? :: boolean) :: boolean
  def score?(false, false), do: false
  def score?(_, _), do: true

  @doc """
  Pacman loses if he touches a ghost without a power pellet.
  """
  @spec lose?(power_pellet_active? :: boolean, touching_ghost? :: boolean) :: boolean
  def lose?(false, true), do: true
  def lose?(_, _), do: false

  @doc """
  Pacman only wins after eating all dots and not touching any ghosts without a power pellet.
  """
  @spec win?(
          has_eaten_all_dots? :: boolean,
          power_pellet_active? :: boolean,
          touching_ghost? :: boolean
        ) :: boolean
  def win?(has_eaten_all_dots?, power_pellet_active?, touching_ghost?) when has_eaten_all_dots?,
    do: not lose?(power_pellet_active?, touching_ghost?)

  def win?(_), do: false
end
