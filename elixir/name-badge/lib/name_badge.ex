defmodule NameBadge do
  @type id :: integer | nil
  @type name :: String.t()
  @type department :: String.t() | nil

  @spec print(id(), name(), department()) :: String.t()
  def print(id, name, department), do: "#{format_id(id)}#{name} - #{format_dept(department)}"

  @spec format_id(id()) :: String.t()
  defp format_id(id), do: if(id, do: "[#{id}] - ", else: "")

  @spec format_dept(department()) :: String.t()
  defp format_dept(dept), do: if(dept, do: String.upcase(dept), else: "OWNER")
end
