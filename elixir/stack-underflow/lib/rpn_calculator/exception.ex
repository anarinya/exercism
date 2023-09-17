defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    @default_message "stack underflow occurred"
    defexception message: @default_message

    @impl true
    def exception([]), do: %StackUnderflowError{}

    def exception(value),
      do: %StackUnderflowError{message: "#{@default_message}, context: #{value}"}
  end

  def divide(stack) when length(stack) < 2, do: raise(StackUnderflowError, "when dividing")
  def divide([0, _]), do: raise(DivisionByZeroError)
  def divide([n1, n2]), do: div(n2, n1)
end
