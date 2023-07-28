defmodule BirdCount do
  # Returns today's count
  @spec today(daily_bird_counts :: list) :: integer | nil
  def today([]), do: nil
  def today([head | _tail]), do: head

  # Returns daily bird count with today's count incremented by 1
  @spec increment_day_count(daily_bird_counts :: list) :: list
  def increment_day_count([]), do: [1]
  def increment_day_count([head | tail]), do: [head + 1 | tail]

  # Returns true if there is a day without birds
  @spec has_day_without_birds?(daily_bird_counts :: list) :: boolean
  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([head | _tail]) when head == 0, do: true
  def has_day_without_birds?([_head | tail]), do: has_day_without_birds?(tail)

  # Returns total count of all birds
  @spec total(daily_bird_counts :: list) :: integer
  def total([]), do: 0
  def total([head | tail]), do: head + total(tail)

  # Returns count of days where at least 5 birds were seen
  @spec busy_days(daily_bird_counts :: list) :: integer
  def busy_days([]), do: 0
  def busy_days([head | tail]) when head >= 5, do: 1 + busy_days(tail)
  def busy_days([_head | tail]), do: busy_days(tail)
end
