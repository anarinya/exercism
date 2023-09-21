defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts()) :: {:ok, opts()} | {:error, error()}
  @callback handle_frame(dot(), frame_number(), opts()) :: dot()

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation
      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def handle_frame(%{opacity: opacity} = dot, frame_number, _opts) do
    case rem(frame_number, 4) do
      0 -> %{dot | opacity: opacity / 2}
      _ -> dot
    end
  end
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def init([{:velocity, n}] = opts) when is_number(n), do: {:ok, opts}

  def init(opts) do
    velocity = inspect(opts[:velocity])
    {:error, "The :velocity option is required, and its value must be a number. Got: #{velocity}"}
  end

  @impl DancingDots.Animation
  def handle_frame(%{radius: radius} = dot, frame_number, velocity: velocity) do
    %{dot | radius: radius + (frame_number - 1) * velocity}
  end
end
