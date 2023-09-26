defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count([]), do: 0
  def count([_head | tail]), do: 1 + count(tail)

  @spec reverse(list) :: list
  def reverse(list), do: do_reverse(list, [])

  @spec do_reverse(list, list) :: list
  defp do_reverse([], memo), do: memo
  defp do_reverse([head | tail], memo), do: do_reverse(tail, [head | memo])

  @spec map(list, (any -> any)) :: list
  def map(list, func), do: do_map(list, func)

  @spec do_map(list, fun) :: list
  defp do_map([], _func), do: []
  defp do_map([head | tail], func), do: [func.(head) | do_map(tail, func)]

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(list, func), do: do_filter(list, func)

  @spec do_filter(list, fun) :: list
  defp do_filter([], _func), do: []

  defp do_filter([head | tail], func),
    do: if(func.(head), do: [head | do_filter(tail, func)], else: do_filter(tail, func))

  @type acc :: any
  @spec foldl(list, acc, (any, acc -> acc)) :: acc
  def foldl(list, acc, func), do: do_foldl(list, acc, func)

  @spec do_foldl(list, integer, fun) :: list
  defp do_foldl([], acc, _func), do: acc
  defp do_foldl([head | tail], acc, func), do: do_foldl(tail, func.(head, acc), func)

  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr(list, acc, func), do: do_foldr(reverse(list), acc, func)

  @spec do_foldr(list, integer, fun) :: integer
  defp do_foldr([], acc, _func), do: acc
  defp do_foldr([head | tail], acc, func), do: do_foldr(tail, func.(head, acc), func)

  @spec append(list, list) :: list
  def append(a, b), do: do_append(a, b)

  @spec do_append(list, list) :: list
  defp do_append([], b), do: b
  defp do_append([head | tail], b), do: [head | do_append(tail, b)]

  @spec concat([[any]]) :: [any]
  def concat(lists), do: do_concat(lists)

  @spec do_concat(list(list)) :: list
  defp do_concat([]), do: []
  defp do_concat([[tail]]), do: [tail]
  defp do_concat([[] | rest]), do: do_concat(rest)
  defp do_concat([[head | tail] | rest]), do: [head | do_concat([tail | rest])]
end
