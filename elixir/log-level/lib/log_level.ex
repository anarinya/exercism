defmodule LogLevel do
  @moduledoc """
  Gives logs labels based on severity levels.
  """

  @typedoc """
  A tuple with a log level integer and a legacy? status boolean.
  """
  @type log_level_with_legacy_status :: {atom, boolean}

  @doc """
  Takes an integer code `level` and `legacy?` boolean of whether or not the log comes
  from a legacy app, and returns the label of a log line as an atom.
  """
  @spec to_label(level :: integer, legacy? :: boolean) :: atom
  def to_label(0, false), do: :trace
  def to_label(1, _), do: :debug
  def to_label(2, _), do: :info
  def to_label(3, _), do: :warning
  def to_label(4, _), do: :error
  def to_label(5, false), do: :fatal
  def to_label(_, _), do: :unknown

  @doc """
  Takes integer code `level` and `legacy?` flag, uses it to identify recipient.
  """
  @spec alert_recipient(level :: integer, legacy? :: boolean) :: atom
  def alert_recipient(level, legacy?), do: {to_label(level, legacy?), legacy?} |> recipient

  # Matches log level and legacy status to where it needs to go
  @spec recipient(log_level_with_legacy_status) :: atom
  defp recipient({:error, _}), do: :ops
  defp recipient({:fatal, _}), do: :ops
  defp recipient({:unknown, true}), do: :dev1
  defp recipient({:unknown, _}), do: :dev2
  defp recipient(_), do: false
end
