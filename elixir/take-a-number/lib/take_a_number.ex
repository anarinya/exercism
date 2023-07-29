defmodule TakeANumber do
  @moduledoc """
  Module for spawning a process that gives out consecutive numbers.

  ## Examples
  iex> pid = TakeANumber.start()
  iex> send(pid, {:report_state, self()})
  iex> send(pid, {:take_a_number, self()})
  iex> send(pid, :stop)
  iex> receive do msg -> msg end
  """

  @doc """
  Spawns a new ticketer process.

  ## Examples
  iex> pid = TakeANumber.start()
  """
  @spec start() :: pid()
  def start(), do: spawn(fn -> ticketer(0) end)

  # Receives and processes ticketer messages.
  @spec ticketer(state :: integer) :: :ok
  defp ticketer(state) do
    receive do
      {:report_state, requester_pid} ->
        send(requester_pid, state)
        ticketer(state)

      {:take_a_number, requester_pid} ->
        send(requester_pid, state + 1)
        ticketer(state + 1)

      :stop ->
        exit(:normal)

      _ ->
        ticketer(state)
    end
  end
end
