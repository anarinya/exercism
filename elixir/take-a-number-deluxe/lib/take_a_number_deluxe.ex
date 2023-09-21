defmodule TakeANumberDeluxe do
  use GenServer
  # Client API

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_args) do
    GenServer.start_link(__MODULE__, init_args)
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine), do: GenServer.call(machine, :get_current_state)

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine), do: GenServer.call(machine, :get_new_number)

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    GenServer.call(machine, {:get_next_queued_number, priority_number})
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine), do: GenServer.cast(machine, :reset_state)

  # Server callbacks
  @impl GenServer
  def init(args) do
    timeout = Keyword.get(args, :auto_shutdown_timeout, :infinity)

    case TakeANumberDeluxe.State.new(args[:min_number], args[:max_number], timeout) do
      {:ok, state} -> {:ok, state, timeout}
      {:error, error} -> {:stop, error}
    end
  end

  @impl GenServer
  def handle_call(:get_current_state, _from, %{auto_shutdown_timeout: timeout} = state) do
    {:reply, state, state, timeout}
  end

  def handle_call(:get_new_number, _from, %{auto_shutdown_timeout: timeout} = state) do
    case TakeANumberDeluxe.State.queue_new_number(state) do
      {:ok, new_number, new_state} -> {:reply, {:ok, new_number}, new_state, timeout}
      {:error, error} -> {:reply, {:error, error}, state, timeout}
    end
  end

  def handle_call({:get_next_queued_number, priority_number}, _from, state) do
    %{auto_shutdown_timeout: timeout} = state

    case TakeANumberDeluxe.State.serve_next_queued_number(state, priority_number) do
      {:ok, next_number, new_state} -> {:reply, {:ok, next_number}, new_state, timeout}
      {:error, error} -> {:reply, {:error, error}, state, timeout}
    end
  end

  @impl GenServer
  def handle_cast(:reset_state, %{auto_shutdown_timeout: timeout} = state) do
    {:ok, new_state} = TakeANumberDeluxe.State.new(state.min_number, state.max_number, timeout)
    {:noreply, new_state, timeout}
  end

  @impl GenServer
  def handle_info(:timeout, _), do: exit(:normal)

  def handle_info(_, %{auto_shutdown_timeout: timeout} = state), do: {:noreply, state, timeout}
end
