defmodule TopSecret do
  def to_ast(string), do: Code.string_to_quoted!(string)

  def decode_secret_message_part({op, _, _} = ast, acc) when op in [:def, :defp] do
    {name, arity} = get_function_name_and_arity(ast)
    {ast, [to_string(name) |> String.slice(0, arity) | acc]}
  end

  def decode_secret_message_part(ast, acc), do: {ast, acc}

  defp get_function_name_and_arity({_, _, [h | _]}) do
    case h do
      {:when, _, _} -> get_function_name_and_arity(h)
      {name, _, args} when is_list(args) -> {name, length(args)}
      {name, _, _} -> {name, 0}
    end
  end

  def decode_secret_message(string) do
    ast = to_ast(string)
    {_, acc} = Macro.prewalk(ast, [], &decode_secret_message_part/2)
    acc |> Enum.reverse() |> Enum.join()
  end
end
