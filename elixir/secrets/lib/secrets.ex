defmodule Secrets do
  @moduledoc """
  Secrets module meant to be used for an encryption device that works
  by performing transformations on data. All functions return anonymous
  functions.
  """
  import Bitwise

  @doc """
  Returns a function that takes a a secret and adds an arg given later to
  the secret.
  """
  @spec secret_add(integer) :: fun()
  def secret_add(secret), do: &(secret + &1)

  @doc """
  Returns a function that takes a secret and subtracts an arg given later from
  the secret.
  """
  @spec secret_subtract(integer) :: fun()
  def secret_subtract(secret), do: &(&1 - secret)

  @doc """
  Returns a function that takes a secret and multiplies it with an arg given
  later.
  """
  @spec secret_multiply(integer) :: fun()
  def secret_multiply(secret), do: &(secret * &1)

  @doc """
  Returns a function that takes a secret and divides it by an arg given later.
  """
  @spec secret_divide(integer) :: fun
  def secret_divide(secret), do: &div(&1, secret)

  @doc """
  Returns a function that takes a secret and applies a bitwise 'and' operation on
  it and an arg given later.
  """
  @spec secret_and(integer) :: fun()
  def secret_and(secret), do: &band(&1, secret)

  @doc """
  Returns a function that takes a secret and applies a bitwise 'xor' operation on
  it and an arg given later.
  """
  @spec secret_xor(integer) :: fun()
  def secret_xor(secret), do: &bxor(&1, secret)

  @doc """
  Returns a function that applies 2 given functions to an arg given later.

  ## Examples
    iex> multiply = Secrets.secret_multiply(7)
    iex> divide = Secrets.secret_divide(3)
    iex> combined = Secrets.secret_combine(multiply, divide)
    iex> combined.(6)
    14
  """
  @spec secret_combine(fun(), fun()) :: fun()
  def secret_combine(secret_function1, secret_function2) do
    &(&1 |> secret_function1.() |> secret_function2.())
  end
end
