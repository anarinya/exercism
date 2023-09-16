defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []), do: Agent.start(fn -> %{count: 0, plots: []} end, opts)

  def list_registrations(pid), do: Agent.get(pid, &Map.get(&1, :plots))

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn %{plots: plots, count: count} ->
      new_id = count + 1
      new_plot = %Plot{plot_id: new_id, registered_to: register_to}
      {new_plot, %{plots: [new_plot | plots], count: new_id}}
    end)
  end

  def release(pid, plot_id) do
    Agent.cast(pid, fn %{plots: plots} = state ->
      updated_plots = Enum.filter(plots, &(Map.get(&1, :plot_id) != plot_id))
      %{state | plots: updated_plots}
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn %{plots: plots} ->
      not_found = {:not_found, "plot is unregistered"}
      Enum.find(plots, not_found, &(Map.get(&1, :plot_id) == plot_id))
    end)
  end
end
