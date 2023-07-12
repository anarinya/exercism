defmodule FreelancerRates do
  @moduledoc """
  Utilities to calculate daily and monthly rates, optionally with a
  given discount.

  The daily rate is 8 times the hourly rate.
  A month has 22 billable days.
  """

  @daily_billable_hours 8.0
  @monthly_billable_days 22

  @doc """
  Calculate the daily rate when given an hourly rate.
  """
  @spec daily_rate(number) :: float
  def daily_rate(hourly_rate), do: hourly_rate * @daily_billable_hours

  @doc """
  Calculate an updated price after applying a discount.
  """
  @spec apply_discount(number, number) :: float
  def apply_discount(before_discount, discount), do: before_discount * (1 - discount / 100)

  @doc """
  Calculates the total month's pay, given an hourly rate and discount.
  """
  @spec monthly_rate(number, number) :: integer
  def monthly_rate(hourly_rate, discount) do
    daily_rate(hourly_rate)
    |> Kernel.*(@monthly_billable_days)
    |> apply_discount(discount)
    |> ceil
  end

  @doc """
  Calculates how many days of work are covered, given a budget, hourly rate,
  and a discount.
  """
  @spec days_in_budget(number, number, number) :: float
  def days_in_budget(budget, hourly_rate, discount) do
    daily_rate(hourly_rate)
    |> apply_discount(discount)
    |> then(&Float.floor(budget / &1, 1))
  end
end
