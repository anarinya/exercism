defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new(nickname \\ "none"), do: %__MODULE__{nickname: nickname}

  def display_distance(%__MODULE__{distance_driven_in_meters: distance}),
    do: "#{distance} meters"

  def display_battery(%__MODULE__{battery_percentage: battery}) do
    case battery > 0 do
      true -> "Battery at #{battery}%"
      _ -> "Battery empty"
    end
  end

  def drive(%__MODULE__{} = remote_car) do
    %{battery_percentage: battery, distance_driven_in_meters: distance} = remote_car

    case battery > 0 do
      true ->
        %{remote_car | battery_percentage: battery - 1, distance_driven_in_meters: distance + 20}

      _ ->
        remote_car
    end
  end
end
