defmodule LibraryFees do
  @spec datetime_from_string(String.t()) :: NaiveDateTime.t()
  def datetime_from_string(string), do: NaiveDateTime.from_iso8601!(string)

  @spec before_noon?(NaiveDateTime.t()) :: boolean
  def before_noon?(datetime), do: datetime.hour < 12

  @spec return_date(NaiveDateTime.t()) :: Date.t()
  def return_date(checkout_datetime) do
    Date.add(checkout_datetime, days_to_add(checkout_datetime))
  end

  @spec days_to_add(NaiveDateTime.t()) :: integer
  defp days_to_add(datetime), do: if(before_noon?(datetime), do: 28, else: 29)

  @spec days_late(Date.t(), NaiveDateTime.t()) :: integer
  def days_late(planned_return_date, actual_return_datetime) do
    case Date.compare(actual_return_datetime, planned_return_date) do
      :lt -> 0
      :eq -> 0
      :gt -> Date.diff(actual_return_datetime, planned_return_date)
    end
  end

  @spec monday?(NaiveDateTime.t()) :: boolean
  def monday?(datetime), do: Date.day_of_week(datetime) == 1

  @spec calculate_late_fee(String.t(), String.t(), integer) :: integer
  def calculate_late_fee(checkout, return, rate) do
    checkout_date = datetime_from_string(checkout)
    return_date = datetime_from_string(return)
    days_late = days_late(return_date(checkout_date), return_date)

    cond do
      days_late == 0 -> 0
      monday?(return_date) -> floor(days_late * rate / 2)
      true -> floor(days_late * rate)
    end
  end
end
