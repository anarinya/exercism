defmodule GuessingGame do
  @spec compare(secret_number :: integer, guess :: any) :: String.t()
  def compare(secret_number, guess \\ :no_guess)

  def compare(_secret_number, guess) when not is_integer(guess), do: "Make a guess"

  def compare(secret_number, guess) when secret_number == guess, do: "Correct"

  def compare(secret_number, guess)
      when guess == secret_number + 1 or guess == secret_number - 1,
      do: "So close"

  def compare(secret_number, guess) when guess > secret_number, do: "Too high"
  def compare(secret_number, guess) when guess < secret_number, do: "Too low"
end
